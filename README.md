# Glowingadventure

Brief overview of the features.

The database stuff is just template generated.  I'm a huge fan of Elixir contexts so I wanted to make sure we had at least one to work with.  I didn't do a whole lot there because the auto-generated stuff is pretty easy, just run a bunch of commands, add some database relationships, and you've got a CRUD app.

The persisted analyses are stored in a GenServer. ets is of course another option for storage, but the GenServer gives us the option of trapping exits, which means we can take actions when the process terminates. In this case, I'm saving to the database so we can restore from the database later on startup. My assumption was that this is throwaway data where we're keeping it for user convenience. If it were more important, we'd want to save it to the database right away and use the GenServer for performance reasons. I picked this approach mostly so we'd have a robust GenServer to work with, normally I'd try to get more requirements around the importance of the data.

And the multiple analysis functions are going to be handled with callbacks. Basically we can just implement the same method across multiple modules and then swap in the backend we want to use. It's pretty nice for when you've got the same functionality but different approaches.

To use the various scripts:

  * Have Docker installed
  * Run script/dev_setup to compile and setup the database
  * Run script/dev_run to run the Phoenix server in dev mode
  * Run script/test to run tests

Runs on [`localhost:4000`](http://localhost:4000)