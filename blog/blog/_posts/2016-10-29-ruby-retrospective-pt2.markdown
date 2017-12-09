---
layout: post
title:  "Ruby Retrospective Part 2"
date:   2016-10-29 10:03:10 -0700
---

Part 2 of my Ruby retrospective discussing my progress through [The Odin Project!](http://www.theodinproject.com/courses/ruby-programming)
<br><br>[Link to part 1.]({% post_url 2016-10-26-ruby-retrospective-pt1 %})




<h1>Stock Picker</h1>

Another relatively simple project, this time my first project to make my own method calls within another method. Looking back this solution doesn't particularly scale very well over a larger amount of data points, each new value in the array causes the program to iterate through the rest of the array. I'm not sure how to optimize this to be less intensive so any ideas would be very helpful here.

Original code:

{% highlight ruby %}
def stock_picker(price_array)
  i = 0
  lowest_day = 0
  greatest_difference = 0
  while i < price_array.length - 1
      difference = find_highest_difference(price_array, i)
      if difference > greatest_difference
        greatest_difference = difference  
      end
    i += 1
  end
  puts greatest_difference
  
end

def find_highest_difference(previous_array, place_in_array)
  highest_difference = 0
  while place_in_array < previous_array.length
    i = place_in_array + 1
    while i < previous_array.length
      if previous_array[i] - previous_array[place_in_array] > highest_difference
        highest_difference = previous_array[i] - previous_array[place_in_array]
      end
      i += 1
    end
    place_in_array += 1
  end
  return highest_difference
end
{% endhighlight %}

With some easy ruby fixes:
{% highlight ruby %}
def stock_picker(price_array)
  i = 0
  greatest_difference = 0
  while i < price_array.length - 1
      difference = find_highest_difference(price_array, i)
      if difference > greatest_difference
        greatest_difference = difference  
      end
    i += 1
  end
  greatest_difference 
end

def find_highest_difference(previous_array, place_in_array)
  highest_difference = 0
  while place_in_array < previous_array.length
    i = place_in_array + 1
    while i < previous_array.length
      if previous_array[i] - previous_array[place_in_array] > highest_difference
        highest_difference = previous_array[i] - previous_array[place_in_array]
      end
      i += 1
    end
    place_in_array += 1
  end
  highest_difference
end
{% endhighlight %}

