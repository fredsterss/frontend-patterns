# 
# *************
# INTRO
# *************
# 
# This is an example view, which documents the various patterns we use in out backbone
# app. Custom stuff that is part of our mini-framework are denoted with a *
# 
# While looking through this view, you may want to look at the patterns implemented
# throughout the codebase to get a better idea of how they work in production. If 
# you find yourself wondering how to do something with Backbone, you should probably
# look here first.
# 
# Before you start here, you probably want to understand a few core concepts (It's 
# likely the most efficient way to do this is speak with a human):
# - how Backbone renders, treats elements, and treats each view
# - how routing works in Backbone
# - how models work
# - how collections work
# 

# to start with, we define the view as extending the BaseView class. It will now
# be accessible globally as ExampleView.
class @ExampleView extends BaseView


  # 
  # *************
  # VIEW OPTIONS
  # *************
  # 
  # There are then a number of options that we define at the head of the view. 
  # First, the custom ones that are part of our mini-framework.
  # 
  # NB: There are a bunch of helper functions that rely on the element being
  # present when the helper function is called. If one of the 'magic' things
  # isn't working as expected, it's typically related to when the element is
  # rendered / re-rendered, so start there. The first step is typically checking
  # for the existence of the element you're targeting in the code.

  # Template *
  # Defining the template here allows us to use our template rendering helper 
  # function@renderTemplate() later on in the view.
  template: "example/example"

  # Help *
  # This gives us a way to define help tooltips (e.g. http://cl.ly/image/0I0A3U3T2x2c) 
  # This is an object, with each key being a jquery selector for an element that the help
  # icon will be appended to, and each value being  and each value
  # being a string that is displayed.
  help:
    ".some-selector": "This string will be displayed to the user when they hover over the help tooltip"


  # 
  # Backbone builtins
  # 
  # This just covers the common ones. There's a ton, listed here: http://backbonejs.org/#View-constructor
  
  # className
  # This defines the class of the view. Pattern is "view-name-view", i.e. "example-view"
  className: "example-view"

  # tagName
  # This defines the kind of root element this view is. For example, you could set it to
  # "ol", which would be an ordered list, or "table". Defaults to div.
  tagName: "ul"

  # Events
  # This is a hash of all the events to be listened to in this view, and the function 
  # that should be called when the event is triggered.
  events:
    "click .title": "functionToCall"

    # clickHandler *
    # This intercepts links and uses the backbone navigate method if the link has data-nav="true",
    # to allow the user to navigate through the app without full page refreshes. It works by setting 
    # the 'click a' event to "clickHandler". For example:
    "click a": "clickHandler"

    # keyHandler *
    # Calls key-specific functions (i.e. keyEscape, keyBackspace, keyCtrlEnter etc) if they are present 
    # within your view, based on events. For example, if you wanted to do something when the customer hits
    # enter in any input, do:
    "keyup input": "keyHandler"
    # with a corresponding keyEnter function somewhere within the view. For a full list of supported
    # key-specific functions, look at the keyHandler function within the BaseView.


  # 
  # *************
  # CONSTRUCTOR
  # *************
  # 
  # The pattern is to explicitly define all the dependencies you are using in each view within this
  # initialize function, so that other people working on the codebase can easily tell what this 
  # view depends on when refactoring.
  # 
  # This maps all options passed through during view creation to @options (this.options) so they
  # are available to every function within this view.
  initialize: (@options) ->

    # let's say we passed in an ExampleModel as model:
    @example = @options.example


  # 
  # *************
  # RENDER
  # *************
  # 
  # The render function squirts something into the 'el' of this view. You can then do whatever
  # you want with the el of this view. There are a couple of patterns here:
  # 
  # 1. Use renderTemplate([options]) to render the template into the el. Example below.
  # 
  # 2. Call 'super' at the end of this function
  # This calls the parent render function within the BaseView class, which triggers the individual
  # 'magic' functions of the framework. You must do this.
  # 
  # 3. Return the view at the end of this function
  # Coffeescript automatically returns the last line of any function. So simply putting @ (aka this)
  # as the last line of this function returns this view. The reason for this is so we can access 
  # the properties of this view after the render function is called when we render this view elsewhere.
  # A typical pattern for this is:
  # view = new ExampleView
  # $('.container-el').html view.render().el
  # 
  render: ->

    # using renderTemplate
    @$el.html @renderTemplate
      option1: option1
      option2: option2

    super

    @

  # 
  # *************
  # CLOSE
  # *************
  # 
  # There's a bunch of stuff that is done by the close function. There may be view-specific things 
  # you want to do here. For example, you may want to ensure that a popover that may have been
  # opened is cleaned up from the DOM. In that case you can override close and then call super. e.g.
  # close: ->
  #    # do stuff...
  #    super
  #    


  # 
  # *************
  # BUTTONS
  # *************
  # 
  # We use the buttons pattern extensively throughout the app. The pattern is basically as follows:
  # define a button in the DOM. The renderButtons helper function within the BaseView (automatically
  # called by the parent render function through 'super') assigns a ButtonView to each button. The 
  # button is then added to an internal @buttons hash, with the key defined in the DOM. e.g. @buttons.key.
  # There are a bunch of helper functions within each ButtonView, which you should see for more.
  # 
  # button format: <div data-button="Run this test now" data-key="run"></div>
  # 
  # When the button is clicked it will try and call an onKey function within your view. For the example 
  # above, it would call onRun.
  #
  onRun: ->
    # do some functionality...

    # then y















