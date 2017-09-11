defmodule TestAppWeb.Router do
  use TestAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug TestApp.CurrentUser
  end

  pipeline :login_required do
    plug Guardian.Plug.EnsureAuthenticated, 
      handler: TestAppWeb.GuardianErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    scope "/v1" do
      pipe_through :api

      resources "/todos", TodoController
    end
  end
  scope "/", TestAppWeb do
    pipe_through [:browser, :with_session] # Use the default browser stack

    get "/", PageController, :index

    scope "/" do
      pipe_through [:login_required]

      resources "/posts", PostController do
        resources "/comments", CommentController, only: [:create]
      end
      resources "/users", UserController
    end

    scope "/" do

      resources "/session", SessionController, only: [:new, :create, :delete]
      resources "/registration", RegistrationController, only: [:new, :create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestAppWeb do
  #   pipe_through :api
  # end
end
