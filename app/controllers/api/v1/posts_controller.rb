# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!

      def index
        posts = Post.all
        json_response(posts)
      end
    end
  end
end
