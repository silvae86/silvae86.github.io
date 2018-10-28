Jekyll::Hooks.register :site, :pre_render do |site, payload|
  binding.pry
  some_method          # Execution will stop here.
  puts 'Goodbye World' # Run 'next' in the console to move here.

  payload['injected_garbage'] = 'lolada'
end
