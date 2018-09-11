defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> infix_to_postfix
    |> eval_postfix_tokens

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  defp tag_token(token) do
    case token do
        "+" -> {:rator, 1, &(&1 + &2)}
        "-" -> {:rator, 1, &(&2 - &1)}
        "*" -> {:rator, 2, &(&1 * &2)}
        "/" -> {:rator, 2, &(&2 / &1)}
        x   -> {:rand, elem(Float.parse(x), 0)}
      end
  end

  defp tag_tokens(tokens), do: Enum.map(tokens, &tag_token/1)
  
  defp infix_to_postfix(tokens), do: infix_to_postfix(tokens, [])

  defp infix_to_postfix(tokens, stack) do
    case {tokens, stack} do
        {[], stack} -> stack
        {[{:rand, _} | rest], stack} -> [hd tokens] ++ infix_to_postfix(rest, stack)
        {[{:rator, priority, _} | rest_input], stack} ->
          with {o_stack, r_stack} <- Enum.split_while(stack, (fn({_, o_priority, _}) -> o_priority >= priority end)) do
            o_stack ++ infix_to_postfix(rest_input, [hd tokens] ++ r_stack)
          end
      end
  end

  defp eval_postfix_tokens(tokens), do: eval_postfix_tokens(tokens, [])

  defp eval_postfix_tokens(tokens, stack) do
    case {tokens, stack} do
        {[], stack} -> hd stack
        {[{:rand, n} | rest], stack} -> eval_postfix_tokens(rest, [n] ++ stack)
      {[{:rator, _, op} | rest], [a, b | r_stack]} -> eval_postfix_tokens(rest, [op.(a, b)] ++ r_stack)
      end
  end

  def factor(x) do
    if x == 1 do
      []
    else
      f = factor_helper(x, 2)
      [f] ++ factor(div(x, f))
    end
  end

  defp factor_helper(x, f) do
    if rem(x, f) == 0 do
      f
    else
      factor_helper(x, f + 1)
    end
  end
end
