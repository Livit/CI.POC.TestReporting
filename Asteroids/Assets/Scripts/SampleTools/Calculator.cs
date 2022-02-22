using System;

namespace SampleTools
{
    public class Calculator
    {

        public int PerformOperation(string operation, int left, int right)
        {
            switch (operation)
            {
                case "-":
                    return left - right;
                case "+":
                    return left + right;
                case "*":
                    return left * right;
                case "/":
                    return left / right;
                default:
                    throw new ArgumentException("Invalid operation", nameof(operation));
            } 
        }
    }
}
