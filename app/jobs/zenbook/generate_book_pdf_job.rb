require 'aws-sdk-lambda'
require 'base64'
require 'json'

module Zenbook
  class GenerateBookPdfJob < ApplicationJob
    queue_as :default

    def perform(book_id)
      book = Book.find(book_id)

      # 1. Render the HTML payload
      # This uses ActionController to parse your markdown and wrap it in your Tailwind layout
      # (Assuming you have a method on the model like `book.parsed_markdown` or similar)
      html_content = ApplicationController.render(
        template: 'zenbook/books/pdf_template',
        assigns: { book: book },
        layout: 'ebook_pdf_layout' 
      )

      # 2. Initialize the AWS Lambda Client
      # Because this runs on your EC2 instance, it automatically grabs the IAM role credentials.
      client = Aws::Lambda::Client.new(region: 'us-east-2')

      # 3. Fire the synchronous request to your Graviton container
      response = client.invoke({
        function_name: 'cloudqubes-pdf-generator',
        invocation_type: 'RequestResponse', # Wait for the PDF to be generated
        payload: { html: html_content }.to_json
      })

      # 4. Parse the Lambda response
      result = JSON.parse(response.payload.string)

      if result['statusCode'] == 200
        # 5. Decode the Base64 string back into raw binary bytes
        pdf_binary = Base64.decode64(result['body'])

        # 6. Attach the file to Active Storage (This automatically uploads it to S3)
        # We use StringIO to trick ActiveStorage into thinking this string in memory is a physical file
        book.pdf_book.attach(
          io: StringIO.new(pdf_binary),
          filename: "#{book.title.parameterize}-cloudqubes.pdf",
          content_type: 'application/pdf'
        )
        book.update(published_at: Time.now)
        # Optional: Update status to 'published'
        # book.update!(status: 'published')
      else
        # 7. Fail loudly if the Node container crashes
        # This ensures Sidekiq/SolidQueue marks the job as failed and can retry it
        raise "Lambda PDF Generation Failed: #{result['body']}"
      end
    end
  end
end


