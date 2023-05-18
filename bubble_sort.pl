=encoding utf8

=head1 bubble_sort.pl

Пузырьковая сортировка. Оптимизация минимальная, так как это вариант для
реализации в виде логической схемы.


=head2 Запуск

 > perl bubble_sort.pl tester.txt

На входе файл, содержащий строки целых чисел с типовыми разделителями C<[,;\s]>

Обрабатываются только строки состоящиетолько из не отрицательных целых числе и разделителей.
Чисел должно быть не менее двух.


=head2 История изменений


=head3 18.05.2023

Сортируются все строки состоящие только из целых положительных чисел.

Результат работы выводится чуть более наглядно.


=head3 16.05.2023

Написана сортировка + анализ входных данных. Сортируется только первая
найденная строка целых положительных чисел.

=cut

use strict;
use warnings;
use feature 'say';
use autodie;

my @ar;

my $line_num;
for my $str (<>) {
    $line_num++;

	# для каждого фрагмента в строке
	for (split /[,;\s]/, $str) {
		next if /^$/;           # пустые пропустить
		if (/^\d+$/) {          # состоящие из одних цыфр - добавить
			push @ar, $_;
		}
		else {                  # фрагмент не является целым неотрицательным числом
			@ar = ();
			last;
		}
	}
	if (@ar > 1) {              # найдена подходящая строка из одних чисел
		say "row $line_num: @{[$#ar + 1]} nums...";

		# собственно сортировка
		# $#ar проходов "утопления" больших чисел
		for (my $max = $#ar; $max > 0; $max--) {
			# утопление наибольшего из оставшихся (не занявших своё место на дне) чисел
			for my $i (1..$max) {
				# требуется поменять числа местами
				if ($ar[$i] < $ar[$i-1]) {
					say "$i\t" . join(', ', @ar[$i-1, $i]) . ' ==> '. join ', ', @ar[$i, $i-1];
					@ar[$i-1, $i] = @ar[$i, $i-1];
				}
				else {
					say "$i\t" . join(', ', @ar[$i-1, $i]);
				}
			}
		}
		say join ', ', @ar;

	}
	@ar = ();
}

__END__

неболльшая дополнительная инструкция по созданию bubble_sort.htm из втроенного POD

@echo off
rem Скрипт для замены html-кодов вида &#xABC; на utf8-символы.
rem
rem Q: Как сделать читаемым результат pod2html когда русские буквы
rem заменяются на html-коды вида &#xABC;
rem
rem A: Использовть регулярные выражения perl.
rem
rem Вызов для конвертации source.html
rem
rem   > patchhtml.bat example.html
rem
rem Резервная копия исходного файла сохраняется с расширением .bak
rem
chcp 65001
set PERLIO=utf8
perl -pi.bak -E"s/&#x([A-F0-9]{2,});/chr(hex($1))/ge" %1