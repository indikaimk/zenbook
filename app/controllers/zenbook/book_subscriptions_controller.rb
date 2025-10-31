module Zenbook
  class BookSubscriptionsController < ApplicationController
    before_action :set_book

    def create
      @subscription = @book.book_subscriptions.new(user: current_user)
      if @subscription.save
        redirect_to @book, notice: "You have subscribed to this book."
      else
        redirect_to @book, alert: "You are already subscribed to this book."
      end
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    end
  end
end
