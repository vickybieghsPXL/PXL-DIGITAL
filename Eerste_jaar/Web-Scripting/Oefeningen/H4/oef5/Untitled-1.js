           
           
           
           
            doc.text("Name: ", x, y);
            doc.text(carData['name'], xData, y);

            doc.text("SKU-nummer:: ", x, y + spacing);
            doc.text(carData['sku'], xData, y + spacing);

            doc.text("Engine: ", x, y + spacing * 2);
            doc.text(carDescription['engine'], xData, y + spacing * 2);

            doc.text("Transmission: ", x, y + spacing * 3);
            doc.text(carDescription['transmission'], xData, y + spacing * 3);

            doc.text("Interieur: ", x, y + spacing * 4);
            doc.text(carDescription['interior'], xData, y + spacing * 4);

            doc.text("Color: ", x, y + spacing * 5);
            doc.text(carDescription['color'], xData, y + spacing * 5);

            doc.text("Brakes: ", x, y + spacing * 6);
            doc.text(carDescription['brakes'], xData, y + spacing * 6);

            doc.text("Miles On Odometer: ", x, y + spacing * 7);
            doc.text(carDescription['miles_ondometer'], xData, y + spacing * 7);

            doc.text("Price: ", x, y + spacing * 8);
            doc.text(carData['price'], xData, y + spacing * 8);




