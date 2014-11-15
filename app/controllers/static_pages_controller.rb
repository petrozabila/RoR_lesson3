class StaticPagesController < ApplicationController
  def contact
    render 'static_pages/contact'
  end

  def about
  	render 'static_pages/about'
  end
end
