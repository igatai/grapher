class ProductionsController < ApplicationController

  def index
    cities = House.pluck(:city).uniq.sort
    # month = [7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6]
    month = Production.where(House_id: 1).pluck(:Month)
    label_num = (0..23).to_a
    @chart = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "Avarage of energy production by erea")
      c.xAxis(categories: month, title: {text: 'month' } )
      c.yAxis(title: {text: 'Avarage of energy production' } )

      # city毎に処理
      cities.each do |city|
        energy_productions_array = []
        houses = House.where(city: city)
        people = 0
        # house毎に処理
        houses.each do |house|
          people += house.num_of_people
          productions = Production.where(House_id: house.id)
          energy_productions_array = []
          # energy_productions_array[]を初期化
          for num in label_num do
            energy_productions_array[num] = 0
          end
          # 月毎に処理
          for num in label_num do
            energy_productions_array[num] += productions.find_by(label: num).EnergyProduction
          end
        end
        # エネルギー消費量の平均を求める
        for num in label_num do
          energy_productions_array[num] /= people if people == 0
        end
        c.series(name: city, data: energy_productions_array )
      end
      c.legend(align: 'right', verticalAlign: 'top', x: -100, y: 180, layout: 'vertical' )
      # c.chart(type: "column" )
    end
  end

  def import
    Production.import(params[:file])
    redirect_to productions_path
  end
end
