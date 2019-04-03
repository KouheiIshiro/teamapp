class AgendasController < ApplicationController
  before_action :set_agenda, only: %i[show edit update destroy]

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.valid?
      @agenda.save
      redirect_to dashboard_url, notice: 'アジェンダ作成に成功しました！'
    else
      redirect_to dashboard_url, notice: 'アジェンダを登録できませんでした'
    end
  end

  def destroy
    @agenda.destroy
    @agenda.team.users.each do |user|
      DestroyReportMailer.destroy_report(@agenda.title, user.email).deliver
    end
    redirect_to dashboard_path, notice: 'アジェンダを削除しました。'
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end
end
