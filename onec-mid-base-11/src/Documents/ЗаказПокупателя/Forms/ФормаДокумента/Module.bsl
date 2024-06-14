
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	// ++ ДЗ_Жигало
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	
	КоэффициентСкидки = 1 - (ТекущиеДанные.Скидка / 100 + Объект.ДЗ_СогласованнаяСкидка / 100);
		Если КоэффициентСкидки <= 0 Тогда
			КоэффициентСкидки = 0;
			ПредупреждениеАсинх("Скидка равна или превышает 100%",,"Не коректная скидка");
		КонецЕсли;
	ТекущиеДанные.Сумма = КоэффициентСкидки * ТекущиеДанные.Цена * ТекущиеДанные.Количество; 
	
	РассчитатьСуммуДокумента()
	//-- ДЗ_Жигало
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти

// ++ ДЗ_Жигало
#Область ВнесенныеИзменения
&НаКлиенте
Процедура ПриИзмененииСкидки(Элемент)
	// ++ ДЗ_Жигало
	Оповещение = Новый ОписаниеОповещения("ПослеЗакрытияВопроса",ЭтотОбъект);
	ПоказатьВопрос(Оповещение, "Изменен процент скидки. Пересчитать таблицы товаров и услуг?",
	РежимДиалогаВопрос.ДаНет,0, КодВозвратаДиалога.Да);
	//-- ДЗ_Жигало
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияВопроса(Результат, Параметры) Экспорт
	// ++ ДЗ_Жигало
	Если Результат = КодВозвратаДиалога.Да Тогда
		ПересчетТабличнойЧасти();
	КонецЕсли;
	//-- ДЗ_Жигало
КонецПроцедуры 

&НаКлиенте
Процедура ПересчитатьТаблицу(Команда)
	// ++ ДЗ_Жигало
	ПересчетТабличнойЧасти();
	//-- ДЗ_Жигало
КонецПроцедуры

&НаКлиенте
Процедура ПересчетТабличнойЧасти()
	// ++ ДЗ_Жигало
	ПересчетТабличнойЧастиТовары();
	ПересчетТабличнойЧастиУслуги();
	//-- ДЗ_Жигало
	//-- ДЗ_Жигало
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура ПересчетТабличнойЧастиТовары()
// ++ ДЗ_Жигало	
	Для Каждого Строка из Объект.Товары Цикл
		КоэффициентСкидки = 1 - (Строка.Скидка / 100 + Объект.ДЗ_СогласованнаяСкидка / 100);
			Если КоэффициентСкидки <= 0 Тогда
				КоэффициентСкидки = 0;
				ПредупреждениеАсинх("Скидка равна или превышает 100%",,"Не коректная скидка");
			КонецЕсли;
		Строка.Сумма = КоэффициентСкидки * Строка.Цена * Строка.Количество;
	КонецЦикла;
//-- ДЗ_Жигало	
КонецПроцедуры

&НаКлиенте
Процедура ПересчетТабличнойЧастиУслуги()
// ++ ДЗ_Жигало		
	Для Каждого Строка из Объект.Услуги Цикл
		КоэффициентСкидки = 1 - (Строка.Скидка / 100 + Объект.ДЗ_СогласованнаяСкидка / 100);
			Если КоэффициентСкидки <= 0 Тогда
				КоэффициентСкидки = 0;
				ПредупреждениеАсинх("Скидка равна или превышает 100%",,"Не коректная скидка");
			КонецЕсли;
		Строка.Сумма = КоэффициентСкидки * Строка.Цена * Строка.Количество;
	КонецЦикла;
//-- ДЗ_Жигало	
КонецПроцедуры


#КонецОбласти
