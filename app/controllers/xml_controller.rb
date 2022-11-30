require 'prime'

class XmlController < ApplicationController
  def max(array)
    arr = array.clone
    s = ''
    arr.sort_by!(&:size).map { |el| s += "#{el.join(' ')}, " if el.size == arr[-1].size }
    s[0...s.length - 2]
  end

  # разделение последовательности на возрастающие подпоследовательнсоти
  def edit(mas)
    ar = []
    m = 0
    (0..mas.count - 2).each do |i|
      if mas[i] >= mas[i + 1]
        ar << mas[m..i]
        m = i + 1
      end
    end
    ar << mas[m..mas.count - 1]
    ar.select { |x| x.length > 1 }
  end

  # разделение на подпоследовательности
  def cons(mas)
    a = []
    mas.each { |x| (2..x.size).each { |n| x.each_cons(n) { |el| a.push(el) } } }
    a
  end

  def compute
    @input = params[:number].split(' ').map(&:to_i)
    check

    respond_to do |format|
      format.xml { render xml: @result.to_xml }
      format.rss { render xml: @result.to_xml }
    end
  end

  def check
    if (@result = cons(edit(@input))).nil?
      @result = { message: "Для n=#{@input} нет близнецов" }
    else
      @result = @result.map { |x1| { value: x1.join(' ') } }
      @result.unshift({ value: @input.join(' ') })
      @result.push({ value: max(edit(@input.map(&:to_i))) })
    end
  end
end
