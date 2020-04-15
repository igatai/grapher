class HousesController < ApplicationController
  def index
    @houses = House.all
    cities = House.pluck(:city).uniq.sort
    people = House.pluck(:num_of_people).uniq.sort
    max_people = people.max
    min_people = people.min

    @chart = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "Number of family member by region ")
      c.xAxis(categories: people, title: {text: 'Number of households' } )
      c.yAxis(title: {text: 'count' } )

      cities.each do |city|
        family_all = []
        for num in min_people..max_people do
          family_all << House.where(city: city).where(num_of_people: num).count
        end
        c.series(name: city, data: family_all )
      end

      c.legend(align: 'right', verticalAlign: 'top', x: -100, y: 180, layout: 'vertical' )
      c.chart(type: "column" )
    end

    @chart2 = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "Number of family member by region in households with children")
      c.xAxis(categories: people, title: {text: 'Number of households' } )
      c.yAxis(title: {text: 'count' } )

      cities.each do |city|
        family_has_child = []
        for num in min_people..max_people do
          family_has_child << House.where(city: city).where(num_of_people: num).where(has_child: "Yes").count
        end
        c.series(name: city + '(has_child)', data: family_has_child )
      end

      c.legend(align: 'right', verticalAlign: 'top', x: -100, y: 180, layout: 'vertical' )
      c.chart(type: "column" )
    end

  end

  def import
    House.import(params[:file])
    redirect_to houses_url
  end
end
