defmodule Glowingadventure.AnalysesTest do
  use Glowingadventure.DataCase

  alias Glowingadventure.Analyses

  describe "analyses" do
    alias Glowingadventure.Analyses.Analysis

    @valid_attrs %{raw_text: "some raw_text", stop_exclusion: true}
    @update_attrs %{raw_text: "some updated raw_text", stop_exclusion: false}
    @invalid_attrs %{raw_text: nil, stop_exclusion: nil}

    def analysis_fixture(attrs \\ %{}) do
      {:ok, analysis} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Analyses.create_analysis()

      analysis
    end

    # TODO: maybe do better separation of test and dev databases
    test "list_analyses/0 returns all analyses" do
      analysis = analysis_fixture()
      assert Enum.member?(Analyses.list_analyses(), analysis)
    end

    test "get_analysis!/1 returns the analysis with given id" do
      analysis = analysis_fixture()
      assert Analyses.get_analysis!(analysis.id) == analysis
    end

    test "create_analysis/1 with valid data creates a analysis" do
      assert {:ok, %Analysis{} = analysis} = Analyses.create_analysis(@valid_attrs)
      assert analysis.raw_text == "some raw_text"
      assert analysis.stop_exclusion == true
    end

    test "create_analysis/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Analyses.create_analysis(@invalid_attrs)
    end

    test "update_analysis/2 with valid data updates the analysis" do
      analysis = analysis_fixture()
      assert {:ok, %Analysis{} = analysis} = Analyses.update_analysis(analysis, @update_attrs)
      assert analysis.raw_text == "some updated raw_text"
      assert analysis.stop_exclusion == false
    end

    test "update_analysis/2 with invalid data returns error changeset" do
      analysis = analysis_fixture()
      assert {:error, %Ecto.Changeset{}} = Analyses.update_analysis(analysis, @invalid_attrs)
      assert analysis == Analyses.get_analysis!(analysis.id)
    end

    test "delete_analysis/1 deletes the analysis" do
      analysis = analysis_fixture()
      assert {:ok, %Analysis{}} = Analyses.delete_analysis(analysis)
      assert_raise Ecto.NoResultsError, fn -> Analyses.get_analysis!(analysis.id) end
    end

    test "change_analysis/1 returns a analysis changeset" do
      analysis = analysis_fixture()
      assert %Ecto.Changeset{} = Analyses.change_analysis(analysis)
    end
  end
end
