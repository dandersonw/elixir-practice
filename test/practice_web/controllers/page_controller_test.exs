defmodule PracticeWeb.PageControllerTest do
  use PracticeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "cs3650"
  end

  test "double 5", %{conn: conn} do
    conn = post conn, "/double", %{"x" => "5"}
    assert html_response(conn, 200) =~ "10"
  end

  test "calc 3 * 5 - 10 / 2", %{conn: conn} do
    conn = post conn, "/calc", %{"expr" => "3 * 5 - 10 / 2"}
    assert html_response(conn, 200) =~ "10"
  end

  test "factor 255", %{conn: conn} do
    conn = post conn, "/factor", %{"x" => "255"}
    assert html_response(conn, 200) =~ "17"
  end

  test "palindrome aba", %{conn: conn} do
    conn = post conn, "/palindrome", %{"x" => "aba"}
    assert html_response(conn, 200) =~ "is a palindrome"
  end
end
