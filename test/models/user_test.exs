defmodule DailyVocabulary.UserTest do
  use DailyVocabulary.ModelCase

  alias DailyVocabulary.User

  @valid_attrs %{email: "some email", name: "some name", provider: "some provider", token: "some token"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
