﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Oefening7
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        public void DrawStreetInPerspective(Canvas drawingArea,
                               SolidColorBrush brushToUse,
                               double topRoofX,
                               double topRoofY,
                               double width,
                               double height)
        {
            DrawHouse(drawingArea, brushToUse, topRoofX, topRoofY, width * 0.8, height * 0.8);
            DrawHouse(drawingArea, brushToUse, topRoofX + 20 + width, topRoofY, width * 0.8 * 0.8, height * 0.8 * 0.8);
            DrawHouse(drawingArea, brushToUse, topRoofX + 40 + width * 2, topRoofY, width * 0.8 * 0.8 * 0.8, height * 0.8 * 0.8 * 0.8);
            DrawHouse(drawingArea, brushToUse, topRoofX + 60 + width * 3, topRoofY, width * 0.8 * 0.8 * 0.8 * 0.8, height * 0.8 * 0.8 * 0.8 * 0.8);
        }

        private void DrawHouse(Canvas drawingArea,
                               SolidColorBrush brushToUse,
                               double topRoofX,
                               double topRoofY,
                               double width,
                               double height)
        {
            DrawTriangle(drawingArea, brushToUse, topRoofX, topRoofY, width, height);
            DrawRectangle(drawingArea, brushToUse, topRoofX, topRoofY + height, width, height);
        }

        private void DrawTriangle(Canvas drawingArea,
                                  SolidColorBrush brushToUse,
                                  double xPlace,
                                  double yPlace,
                                  double width,
                                  double height)
        {
            DrawLine(drawingArea, brushToUse, xPlace, yPlace, xPlace, yPlace + height);
            DrawLine(drawingArea, brushToUse, xPlace, yPlace + height, xPlace + width, yPlace + height);
            DrawLine(drawingArea, brushToUse, xPlace, yPlace, xPlace + width, yPlace + height);
        }

        private void DrawLine(Canvas drawingArea,
                              SolidColorBrush brushToUse,
                              double startX, double startY,
                              double endX, double endY)
        {
            Line line = new Line();
            line.X1 = startX; line.X2 = endX;
            line.Y1 = startY; line.Y2 = endY;
            line.Stroke = brushToUse;
            line.StrokeThickness = 1;
            drawingArea.Children.Add(line);
        }

        private void DrawRectangle(Canvas drawingArea,
                                   SolidColorBrush brushToUse,
                                   double xPos,
                                   double yPos,
                                   double width,
                                   double height)
        {
            Rectangle rectangle = new Rectangle();
            rectangle.Width = width;
            rectangle.Height = height;
            rectangle.Margin = new Thickness(xPos, yPos, 0, 0);
            rectangle.Stroke = brushToUse;
            drawingArea.Children.Add(rectangle);
        }
    }
}
