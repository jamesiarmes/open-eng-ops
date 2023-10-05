class Services::SampleController < ServicesController
  # before_action :set_service, only: %i[show edit update destroy repo repos team team_children team_members teams]
  # before_action :pagination_params, only: %i[show repos team team_children team_members teams]


  private

  def set_service
    params[:id] ||= params[:sample_id]

    super
  end
end
