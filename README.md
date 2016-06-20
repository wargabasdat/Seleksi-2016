# Cara Memakai R
Guys ni udah sempat cari2 tutorial, dicoba2 dulu ya.

[Basic] - Buat yang basic banget, misal cara compile, ngerun, print, hitung mean tanpa agregasi, dll

[Data import] - cara masukin .csv nya ke variabel

[Hitung mean] - cara hitung rata-rata yang pake agregasi *__Tapi pake library laen__*

[Buat Variabel Kategori] - cara mengelompokkan data ke dalam kategori-kategori

[Buat Value Label] - Membuat label

[R Data Types] - Tipe-tipe data yang ada di R

[ggplot2 cheatsheet] - cheatsheet buat ggplot2, *__AWAS DOWNLOAD!__*

## Seleksi-2016
Seleksi Calon Warga Basdat 2016: Introduction to Data Science

## Spesifikasi Tugas
Pada tugas ini, peserta seleksi calon Warga Basdat diberi kesempatan untuk melakukan eksplorasi lebih jauh tentang data selayaknya seorang Data Scientist. 
Ada 5 pilihan dataset. Eksplorasi cukup dilakukan dengan salah satu dataset saja. 
Setiap dataset sudah disertai dengan soal yang harus dijawab oleh peserta. 
Penjelasan mengenai setiap dataset dapat dibaca pada dokumen Detail Dataset pada masing-masing folder dataset.


### Prosedur Pemilihan Dataset
Pemilihan dataset akan dilakukan dengan melakukan tag terhadap dataset yang kelompok anda inginkan melalui sebuah google sheet, yang akan diberikan ketika kelompok telah kami bentuk pada tanggal 23 Mei 2016.

### Tools
Tools wajib yang harus digunakan peserta dalam mengerjakan tugas ini adalah R atau Python. Kedua bahasa tersebut merupakan tools untuk data analysis yang sedang banyak digunakan saat ini. 
Perbandingan umum kedua bahasa tersebut dapat dilihat pada [link berikut.](https://www.datacamp.com/community/tutorials/r-or-python-for-data-analysis) untuk membantu peserta dalam menentukan bahasa yang akan digunakan dalam pengerjaan tugas ini. 
Peserta diperbolehkan menggunakan package yang sudah tersedia pada masing-masing bahasa, misalnya (namun tidak terbatas pada):

* Python
	* Data Analysis: Scikit Learn ( http://scikit-learn.org/ )
	* Data Visualization: Matplotlib (http://matplotlib.org/)

* R
	* Data Analysis: e1071 (https://cran.r-project.org/web/packages/e1071/)
	* Data Visualization: Ggplot2 (http://ggplot2.org/)

Selain R atau Python, peserta juga diperbolehkan menggunakan tools tambahan yang dirasa perlu untuk menyelesaikan tugas ini.

### Mekanisme Pengerjaan
Tugas ini dikerjakan secara berkelompok. Setiap kelompok terdiri dari **2 orang**. Pembagian kelompok akan ditentukan oleh panitia. Untuk keperluan pembagian kelompok, peserta yang ingin mengundurkan diri diharapkan melakukan konfirmasi melalui email **(basisdata@std.stei.itb.ac.id)** cukup dengan subjek **[SELEKSI BASIS DATA - {NIM} - {NAMA} - PENGUNDURAN DIRI]** paling lambat pada hari **Minggu, 22 Mei 2016 pukul 23.59**. Apabila Anda tidak mengirimkan email tersebut, maka kami mengasumsikan bahwa Anda bersedia untuk mengikuti keseluruhan tahap seleksi kedua calon warga basdat dan Anda siap untuk bertanggung jawab terhadap tugas Anda di dalam kelompok. Pembagian kelompok akan dirilis melalui email pada hari **Senin, 23 Mei 2016**.

Waktu pelaksanaan eksplorasi ini adalah **4 minggu**, terhitung sejak tanggal **23 Mei 2016 hingga 20 Juni 2016 pukul 23.59**. Jika peserta menemui kendala di tengah pelaksanaan eksplorasi, peserta diharapkan segera memberitahu panitia melalui email.

### Deliverables
Untuk pengumpulan deliverables, setiap kelompok harus melakukan fork pada repository ini. Semua deliverables harus di-push ke forked repo tersebut. Setelah selesai, peserta harus melakukan pull request dengan format **[TUGAS_SELEKSI_2_{NIM_ANGGOTA1}_{NIM_ANGGOTA_2}]**. 

Deliverables untuk tugas ini adalah sebagai berikut:
Dokumen laporan softcopy (*.pdf) yang minimal berisi penjelasan singkat dataset, langkah-langkah analisis yang dilakukan terhadap dataset, hasil analisis (untuk menjawab pertanyaan dari dataset), dan visualisasi hasil analisis. 
Script dan semua kode yang digunakan dalam proses analisis. Script dan kode yang dikumpulkan harus terdokumentasi dengan baik (minimal ada komentar singkat untuk menjelaskan kegunaan script/kode tersebut)
Data hasil analisis dalam bentuk csv/json.

### Opsi Soal dan Dataset
Kelima dataset beserta soal dapat diambil pada link [drive ini.](http://bit.ly/datasets_tugas2)

Opsi dataset yang dapat dipilih adalah berikut:
 1. Criminality on San Francisco
 2. Taxi Trip
 3. Salary of San Francisco Citizenship
 4. USA President Election
 5. Take Me Out Indonesia

 ### Referensi

* Cara penggunaan git pada github.
	* http://crunchify.com/how-to-fork-github-repository-create-pull-request-and-merge 
	* https://www.atlassian.com/git/tutorials/ 

* Setup R
	* https://cran.r-project.org/bin/windows/base/ 
	* https://www.digitalocean.com/community/tutorials/how-to-set-up-r-on-ubuntu-14-04  

* Setup Python
	* https://www.python.org/ 
	* http://stackoverflow.com/questions/4750806/how-do-i-install-pip-on-windows 

* Daftar kakas/library untuk visualisasi
	* https://github.com/fasouto/awesome-dataviz, namun beberapa yang sering dipakai adalah(opsional untuk web): 
		* D3
		* Highchart
		* Matplotlib
		* ggplot


### Tambahan

Meskipun Anda mengalami kesusahan dalam menyelesaikan tugas, kami harap agar Anda tetap melanjutkan eksplorasi dan melaporkan langkah2 apa saja yang telah Anda lakukan dan hasilnya. Selamat mengerjakan :)

[Data import]: <http://www.r-tutor.com/r-introduction/data-frame/data-import>
[Hitung mean]: <https://www.miskatonic.org/2012/09/24/counting-and-aggregating-r/>
[Basic]: <http://www.tutorialspoint.com/r/r_basic_syntax.htm>
[Buat Variabel Kategori]: <http://stackoverflow.com/questions/22075592/creating-category-variables-from-numerical-variable-in-r>
[Buat Value Label]: <http://www.statmethods.net/input/valuelabels.html>
[R Data Types]: <http://www.statmethods.net/input/datatypes.html>
[ggplot2 cheatsheet]: <https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf>
