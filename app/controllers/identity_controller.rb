# frozen_string_literal: true

class IdentityController < ApplicationController
  include ServiceHelper

  def new
    render :new
  end

  def create
    request_params = request.env['omniauth.params']
    user_info = request.env['omniauth.auth']

    identity = Identity.create(
      provider: params[:provider],
      user_id: request_params['user_id'],
      service_id: request_params['service_id'],
      uid: user_info.uid,
      token: user_info.credentials.token,
      refresh_token: user_info.credentials.refresh_token
    )

    result = identity ? { notice: t('.success') } : { alert: t('.failure') }
    if identity&.service_id
      redirect_to identity.service, result
    elsif identity&.user_id
      redirect_to identity.user, result
    else
      redirect_to root_path
    end
  end
end
