using NUnit.Framework;
using SampleTools;

namespace Tests
{
    public class CalculatorTests
    {
        [Test]
        public void One_Plus_One_Should_Return_Two()
        {
            var calc = new Calculator();
            Assert.IsTrue(2 == calc.PerformOperation("+", 1, 1));
        }


    }
}