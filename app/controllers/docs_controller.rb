# frozen_string_literal: true

class DocsController < ApplicationController
  skip_before_action :move_to_about

  def about; end

  def contact; end

  def terms; end

  def privacy; end
end
