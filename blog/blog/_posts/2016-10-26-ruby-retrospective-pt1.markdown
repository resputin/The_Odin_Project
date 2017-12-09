---
layout: post
title:  "Ruby Retrospective Part 1"
date:   2016-10-26 14:50:10 -0700
---

This will be a long multipart series looking back at the work I did during the Ruby section of [The Odin Project](http://www.theodinproject.com/courses/ruby-programming). None of this is particularly correct, but I figure that documenting my progress will be a hilarious time capsule of what I struggled with and how much more I can improve things in the future.


<h1>Caesar Cypher</h1>
The first project was [Caesar Cypher](http://www.theodinproject.com/courses/ruby-programming/lessons/building-blocks). 

This is my original solution:

{% highlight ruby %}
def caesar_cipher(input_string, number_shift)
  output_array = []
  input_string.scan(/./) do |match| 
    if match >= "A" && match <= "Z"
      shift_character = match.ord + number_shift
      if shift_character > 90
        shift_character = (shift_character % 90) + 64
      end
      output_array.push(shift_character.chr)
    elsif match >= "a" && match <= "z"
      shift_character = match.ord + number_shift
      if shift_character > 122
        shift_character = (shift_character % 122) + 96
      end
      output_array.push(shift_character.chr)
    else
      output_array.push(match)
    end
  end
  output_string = output_array.join("")
  puts output_string
end
{% endhighlight %}

The biggest takeaway from this project was `ord` which was a big sticking point for me initially because odin doesn't teach it. I also learned `match` and basic regex in this project. Other than that it is relatively simple, I loop around the edges of the alphabet ordinal ranges to shift the letters depending on the input shift. 

Looking at it now I can definitely simplify some of this logic and make the method return a value instead of putting it on the console. I can also update some of the method calls for a more easily readable chunk of code. 

Updated Solution:

{% highlight ruby %}
def caesar_cipher(input_string, number_shift)
  output_array = []
  input_string.scan(/./) do |match| 
    if match >= "A" && match <= "Z"
      shift_character = match.ord + number_shift
      if shift_character > 90
        shift_character = (shift_character % 90) + 64
      end
      output_array << (shift_character.chr)
    elsif match >= "a" && match <= "z"
      shift_character = match.ord + number_shift
      if shift_character > 122
        shift_character = (shift_character % 122) + 96
      end
      output_array << (shift_character.chr)
    else
      output_array << (match)
    end
  end
  output_array.join("")
end
{% endhighlight %}