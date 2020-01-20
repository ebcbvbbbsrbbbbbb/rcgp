using System;
using System.Windows;

namespace GenericAverageClass
{

    public partial class MainWindow : Window
    {
        public abstract class NumericBase<T, U>
        {
            public abstract void Sum(T t);
            public abstract void SetDefault();
            public abstract U GetAverage();

        }

        /* Классы обертки под каждый "числовой" тип */
        public class NumericInt : NumericBase<NumericInt, int>
        {
            int Value { get; set; }
            int Counter { get; set; }
            int AverageValue { get; set; }

            public NumericInt() { }
            public NumericInt(int param)
            {
                this.Value = param;
                this.Counter = 1;
            }
            public override void Sum(NumericInt obj)
            {

                this.Value = checked(this.Value + obj.Value);
                this.Counter += 1;
                this.AverageValue = this.Value / Counter;

            }
            public override void SetDefault()
            {
                this.Value = 0;
                this.AverageValue = 0;
                this.Counter = 0;
            }
            public override int GetAverage()
            {
                return this.AverageValue;
            }
            public static implicit operator NumericInt(int t) => new NumericInt(t);
        }

        public class NumericDouble : NumericBase<NumericDouble, double>
        {
            double Value { get; set; }
            int Counter { get; set; }
            double AverageValue { get; set; }

            public NumericDouble() { }
            public NumericDouble(double param)
            {
                this.Value = param;
                this.Counter = 1;
            }
            public override void Sum(NumericDouble obj)
            {

                this.Value = checked(this.Value + obj.Value);
                this.Counter += 1;
                this.AverageValue = this.Value / Counter;

            }
            public override void SetDefault()
            {
                this.Value = 0;
                this.AverageValue = 0;
                this.Counter = 0;
            }
            public override double GetAverage()
            {
                return this.AverageValue;
            }
            public static implicit operator NumericDouble(double t) => new NumericDouble(t);
        }

        /* etc */


        public class Average<T, U> where T : NumericBase<T, U>, new()
        {
            public T obj;
            public Average()
            {
                obj = new T();
            }
            public void add(T value)
            {
                try
                {
                    obj.Sum(value);
                }
                catch (Exception e)
                {
                    MessageBox.Show(e.Message);
                    return;
                }
            }
            public void reset()
            {
                obj.SetDefault();
            }
            public U average()
            {
                return obj.GetAverage();
            }

        }
        public MainWindow()
        {
            InitializeComponent();
            var avInt = new Average<NumericInt, int>();
            var avDouble = new Average<NumericDouble, double>();
            avInt.add(2);
            avInt.add(3);
            avInt.add(7);
            MessageBox.Show(avInt.average().ToString());
            avInt.reset();
            MessageBox.Show(avInt.average().ToString());
            avDouble.add(2.5);
            avDouble.add(3.5);
            MessageBox.Show(avDouble.average().ToString());
            avDouble.reset();
            MessageBox.Show(avDouble.average().ToString());

        }
    }
}