﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Yıllık-İzin.aspx.cs" Inherits="deneme9.Yıllık_İzin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .vertical-alignment-helper {
            display: table;
            height: 100%;
            width: 100%;
            pointer-events: none;
        }

        .vertical-align-center {
            /* To center vertically */
            display: table-cell;
            vertical-align: middle;
            pointer-events: none;
        }

        .modal-content {
            /* Bootstrap sets the size of the modal in the modal-dialog class, we need to inherit it */
            width: inherit;
            max-width: inherit; /* For Bootstrap 4 - to avoid the modal window stretching full width */
            height: inherit;
            /* To center horizontally */
            margin: 0 auto;
            pointer-events: all;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
           
            var TextBox2 = $('input[id*=TextBox2]')
            var TextBox3 = $('input[id*=TextBox3]')

            var Today = new Date();

            function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + (d.getDate()),
                    year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [year, month, day].join('-');
            }
            var x = new Date(Today);

            var d = new Date(x.getFullYear(), 12, 0);
            TextBox3.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), 0, 1);
            TextBox2.attr('value', formatDate(d));

            function İzinleri_Doldur() {
                $.ajax({
                    url: 'Yıllık-İzin.aspx/Kullanıcı_Bilgileri',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'Şehir_Id': ''}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)

                        var Ad_Soyad = $('input[id=Ad_Soyad]')
                        var Unvan = $('input[id=Unvan]')
                        var Gecen_Yıldan_Devreden_İzin_Süresi = $('input[id=Gecen_Yıldan_Devreden_İzin_Süresi]')
                        var İçinde_Bulunulan_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi = $('input[id=İçinde_Bulunulan_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi]')
                        var Toplam_İzin_Süresi = $('input[id=Toplam_İzin_Süresi]')
                        var Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi = $('input[id=Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi]')
                        var Toplam_İzinden_Kalan_Süre = $('input[id=Toplam_İzinden_Kalan_Süre]')


                        Ad_Soyad.val(temp[0].Kullanıcı_Ad_Soyad)
                        Unvan.val(temp[0].Kullanıcı_Unvan)
                        Gecen_Yıldan_Devreden_İzin_Süresi.val(temp[0].Geçen_Yıldan_Devreden_İzin_Süresi)
                        İçinde_Bulunulan_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi.val(temp[0].İçinde_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi)
                        Toplam_İzin_Süresi.val(temp[0].Toplam_İzin_Süresi)
                        Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi.val(temp[0].Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi)
                        Toplam_İzinden_Kalan_Süre.val(temp[0].Toplam_İzinden_Kalan_Süre)
                        var Süresi_Gün = $('select[id=Süresi_Gün]')
                        if (parseInt(temp[0].Toplam_İzinden_Kalan_Süre) >= 1) {
                            for (var i = 0; i < parseInt(temp[0].Toplam_İzinden_Kalan_Süre); i++) {
                                Süresi_Gün.append("<option value='" + (i + 1) + "'>" + (i + 1) + " Gün" + "</option>")
                            }
                        }
                        else {
                            Süresi_Gün.append("<option value='" + 0 + "'>İzin Hakkın Yok</option>")
                        }
                        

                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            }
            İzinleri_Doldur();
           
            var Talebi_Gönder = $('button[id=Talebi_Gönder]')
            var Talebi_Gönder_Modal = $('button[id=Talebi_Gönder_Modal]')

            Talebi_Gönder.click(function () {
                $('div[id=myModal]').modal('show')
            });
            Talebi_Gönder_Modal.click(function () {
                var Süresi_Gün = $('select[id=Süresi_Gün]')
                var TextBox4 = $('input[id*=TextBox4]')
                var TextBox5 = $('input[id*=TextBox5]')
                var TextBox6 = $('input[id*=TextBox6]')
                var İzinde_Bulunacağı_Açık_Adres = $('input[id=İzinde_Bulunacağı_Açık_Adres]')
                var Acıklama = $('textarea[id=Acıklama]')
      
                var Yol_İzni = $('input[id=Yol_İzni]')


                var Yol_İzni_Durum = "0";
                if (Yol_İzni.is(':checked')) {
                    Yol_İzni_Durum = "1";
                }

                console.log(Süresi_Gün.find('option:selected').attr('value'))
                console.log(TextBox4.val())
                console.log(TextBox5.val())
                console.log(TextBox6.val())
                console.log(İzinde_Bulunacağı_Açık_Adres.val())
                console.log(Acıklama.val());


                $('div[id=myModal]').modal('toggle')

                if (Süresi_Gün.find('option:selected').attr('value') != undefined &&
                    Süresi_Gün.find('option:selected').attr('value') != "0" &&
                    TextBox4.val() != "" &&
                    TextBox5.val() != "" &&
                    TextBox6.val() != "" &&
                    İzinde_Bulunacağı_Açık_Adres.val() != ""&&
                    Acıklama.val()!=""
                )
                {
                    $.ajax({
                        url: 'Yıllık-İzin.aspx/Talebi_Olustur',
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Süresi_Gün': '" + Süresi_Gün.find('option:selected').attr('value')+"'," +
                            "'Başlangıç_Tarih':'" + TextBox4.val()+"'," +
                            "'Bitiş_Tarhi':'" + TextBox5.val()+"'," +
                            "'Göreve_Başlayacağı_Tarih':'" + TextBox6.val()+"'," +
                            "'İzinde_Bulunacağı_Açık_Adres':'" + İzinde_Bulunacağı_Açık_Adres.val()+"'," +
                            "'Yol_İzni':'" + Yol_İzni_Durum+"'," +
                            "'Açıklama':'" + Acıklama.val()+"'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            alert("İşlem Başarılı")
                            İzinleri_Doldur();
                        },
                        error: function () {
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        }
                    });
                }
                else {
                 
                    alert("Lütfen Tüm Alanları Doldurunuz")
                }
                
            });
            var cal_set = $('input[id=cal_set]')
            cal_set.click(function () {
                Tabloyu_Doldur();
            });
            Tabloyu_Doldur();
            function Tabloyu_Doldur() {
                $('#Tablo_Div').empty();

                $('#Tablo_Div').append('<table id="example" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Süre(Gün)</th>' +
                    '<th>Talep Oluşturulma Tar.</th>' +
                    '<th>İzin Bas.Tar.</th>' +
                    ' <th>İzin Bit. Tar.</th>' +
                    ' <th>Göreve Bas. Tar.</th>' +
                    '<th>İzinde Bulunacağı Adres</th>' +
                    ' <th>Açıklama</th>' +
                    '<th>Yol İzni</th>' +
                  
                    '<th>Onay Durum</th>' +
                    '<th>Kargo Durum</th>' +
                    '<th>Yazdır</th>' +
                    '  </tr>' +
                    '</thead>' +
                    ' <tbody id="Tbody">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );

                var Tbody = $('tbody[id=Tbody]')


                
                $.ajax({
                    url: 'Yıllık-İzin.aspx/Tablo_Doldur',
                    type: 'POST',
                    data: "{'Bas_Tar': '" + TextBox2.val() + "','Bit_Tar':'" + TextBox3.val() + "'}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var parsdata = JSON.parse(data.d)

                        Tbody.empty();
                        console.log(parsdata)
                      
                        for (var i = 0; i < parsdata.length; i++) {
                            var Onay_Label = '';
                            if (parsdata[i].Onay_Durum == "0") {
                                Onay_Label = '<span class="label label-warning">Onay Bekleniyor</span>'
                            }
                            if (parsdata[i].Onay_Durum == "1") {
                                Onay_Label = '<span class="label label-info">Onaylandı</span>'

                            }
                            if (parsdata[i].Onay_Durum == "2") {
                                Onay_Label = '<span class="label label-danger">Reddedildi</span>'
                            }
                            var Yol_İzni_ = '';
                            if (parsdata[i].Yol_İzni == "0") {
                                Yol_İzni_ = '<span class="label label-info">Var</span>'

                            }
                            if (parsdata[i].Yol_İzni == "1") {
                                Yol_İzni_ = '<span class="label label-danger">Yok</span>'
                            }

                            var Kargo_Durum_ = '';
                            if (parsdata[i].Kargo_Durum == "1") {
                                Kargo_Durum_ = '<span class="label label-info">Ulaşdı</span>'

                            }
                            else  {
                                Kargo_Durum_ = '<span class="label label-danger">Ulaşmadı</span>'
                            }

                            Tbody.append('<tr>' +
                                '<td>' + parsdata[i].Süre + '</td>' +
                                '<td>' + parsdata[i].Olusturulma_Tar + '</td>' +
                                '<td>' + parsdata[i].İzin_Bas_Tar + '</td>' +
                                '<td>' + parsdata[i].İzin_Bit_Tar + '</td>' +

                                '<td>' + parsdata[i].Göreve_Baslayacagı_Tarih + '</td>' +

                                '<td style="word-break:break-all;" >' + parsdata[i].İzinde_Bulunacağı_Acık_Adres + '</td>' +
                                '<td>' + parsdata[i].Açıklama + '</td>' +
                                '<td>' + Yol_İzni_ + '</td>' +
                              
                                

                                '<td>' + Onay_Label + '</td>' +
                                '<td>' + Kargo_Durum_ + '</td>' +
                                '<td>' + '<a yol_İzni="' + parsdata[i].Yol_İzni + '" İzin_İd="' + parsdata[i].İzin_Id+'" Id="Yıllık_İzin_Yazdır" style="font-size:25px"><i class="fa fa-fw fa-print"></i></a>' + '</td>' +
                            
                                '</tr>'
                            )
                        }




                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

                var Yıllık_İzin_Yazdır = $('a[id=Yıllık_İzin_Yazdır]')
                Yıllık_İzin_Yazdır.click(function () {



                    


                    //var dd = {
                    //    content: [
                    //        { text: 'EDİS PHARMA İLAÇ SANAYİ VE TİC.LTD.ŞTİ. ', alignment: "center", fontSize: 15, bold: true },
                    //        { text: 'Cumhuriyet Mah. Cumhuriyet Cad.No:11/1 ÇEKMEKÖY / İSTANBUL ', alignment: "center" },
                    //        { text: 'YILLIK İZİN FORMU ', alignment: "center", margin: [5, 15, 10, 20] },

                    //        {
                    //            margin: [5, 15, 10, 20],
                    //            table: {

                    //                // headers are automatically repeated if the table spans over multiple pages
                    //                // you can declare how many rows should be treated as headers
                    //                headerRows: 1,
                    //                widths: ['*', '*'],

                    //                body: [
                    //                    [{ text: 'İzin İsteminde Bulunan Personelin ', alignment: "center", colSpan: 2 }, ''],
                    //                    ['Adı ve Soyadı', 'Value 2',],

                    //                ]
                    //            }
                    //        },
                    //        {
                    //            margin: [5, 45, 10, 20],
                    //            table: {

                    //                // headers are automatically repeated if the table spans over multiple pages
                    //                // you can declare how many rows should be treated as headers
                    //                headerRows: 1,
                    //                widths: ['*', '*'],

                    //                body: [
                    //                    [{ text: 'Kullanılacak İzin ', alignment: "center", colSpan: 2 }, ''],
                    //                    ['Süresi', 'Value 2',],
                    //                    [{ text: 'Başlangıç Tarihi', bold: true }, 'Val 2',],
                    //                    [{ text: 'Bitiş Tarihi ', bold: true }, 'Val 2',],
                    //                    [{ text: 'Göreve Başlayacağı Tarih', bold: true }, 'Val 2',],
                    //                    [{ text: 'İzinde Bulunacağı Açık Adres', bold: true }, 'Val 2',],
                    //                    [{ text: 'Yol İzni', bold: true }, 'Val 2',],
                    //                    [{ text: 'İmzası', bold: true, margin: [5, 15, 10, 20], }, 'Val 2',],
                    //                    [{ text: 'Açıklama', bold: true }, 'Val 2',],


                    //                ]
                    //            }
                    //        },
                    //        {
                    //            table: {
                    //                widths: ['*'],
                    //                body: [
                    //                    [
                    //                        { text: 'İlgili Personel   /  /2021 tarihinde izinden dönmüş ve   /  /2021 tarihinde görevine başlamıştır. ', border: [true, true, true, false] },

                    //                    ],
                    //                    [

                    //                        { text: '   ONAY', alignment: "right", border: [true, false, true, true], margin: [15, 15, 10, 35] }
                    //                    ]
                    //                ]
                    //            }
                    //        },



                    //    ]

                    //}

                  

                    $.ajax({
                        url: 'Yıllık-İzin.aspx/İzin_Bilgileri',
                        type: 'POST',
                        data: "{'İzin_Id': '" + $(this).attr('İzin_İd') + "'}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            var temp=JSON.parse(data.d)
                            console.log(temp)
                            var AD = temp[0].AD;
                            var Açıklama = temp[0].Açıklama;
                            var Grup_Tam_Ad = temp[0].Grup_Tam_Ad;
                            var Göreve_Baslayacagı_Tarih = temp[0].Göreve_Baslayacagı_Tarih;
                            var Soyad = temp[0].Soyad;
                            var Süre = temp[0].Süre;
                            var Yol_İzni = temp[0].Yol_İzni;
                            var İzin_Bas_Tar = temp[0].İzin_Bas_Tar;
                            var İzin_Bit_Tar = temp[0].İzin_Bit_Tar;
                            var İzinde_Bulunacağı_Acık_Adres = temp[0].İzinde_Bulunacağı_Acık_Adres;
                            var Olusturulma_Tar = temp[0].Olusturulma_Tar;
                            var Araç_Plaka = temp[0].Araç_Plaka;

                            var Yol_İzni_Yazı = "";

                            if (Yol_İzni == "0") {
                                Yol_İzni_Yazı="VAR"
                            }
                            else {
                                Yol_İzni_Yazı = "YOK"
                            }

                            var Yol_İzinli = {
                                content: [
                                    { text: 'EDİS PHARMA İLAÇ SANAYİ VE TİC.LTD.ŞTİ. ', alignment: "center", fontSize: 15, bold: true },
                                    { text: 'Cumhuriyet Mah. Cumhuriyet Cad.No:11/1 ÇEKMEKÖY / İSTANBUL ', alignment: "center" },
                                    { text: 'YILLIK İZİN FORMU ', alignment: "center", margin: [5, 15, 10, 20] },
                                    {
                                        margin: [5, 15, 10, 20],
                                        table: {

                                            // headers are automatically repeated if the table spans over multiple pages
                                            // you can declare how many rows should be treated as headers
                                            headerRows: 1,
                                            widths: ['*', '*'],

                                            body: [
                                                [{ text: 'İzin İsteminde Bulunan Personelin ', alignment: "center", colSpan: 2 }, ''],
                                                ['Adı ve Soyadı', AD + ' ' + Soyad],
                                                ['Ünvanı ', Grup_Tam_Ad ],
                                            ]
                                        }
                                    },

                                    {
                                        margin: [5, 45, 10, 20],
                                        table: {

                                            // headers are automatically repeated if the table spans over multiple pages
                                            // you can declare how many rows should be treated as headers
                                            headerRows: 1,
                                            widths: ['*', '*'],

                                            body: [
                                                [{ text: 'Kullanılacak İzin ', alignment: "center", colSpan: 2 }, ''],
                                                ['Süresi', Süre +' GÜN' ],
                                                [{ text: 'Başlangıç Tarihi', bold: true }, İzin_Bas_Tar],
                                                [{ text: 'Bitiş Tarihi ', bold: true }, İzin_Bit_Tar ],
                                                [{ text: 'Göreve Başlayacağı Tarih', bold: true }, Göreve_Baslayacagı_Tarih ],
                                                [{ text: 'İzinde Bulunacağı Açık Adres', bold: true }, İzinde_Bulunacağı_Acık_Adres ],
                                                [{ text: 'Yol İzni', bold: true }, Yol_İzni_Yazı ],
                                                [{ text: 'İmzası', bold: true, margin: [5, 15, 10, 20], }, ' ' ],
                                                [{ text: 'Açıklama', bold: true }, Açıklama],


                                            ]
                                        }
                                    },
                                    {
                                        table: {
                                            widths: ['auto'],
                                            body: [
                                                [
                                                    { text: 'İlgili Personel   /  /2021 tarihinde izinden dönmüş ve   /  /2021 tarihinde görevine başlamıştır. ', border: [true, true, true, false] },

                                                ],
                                                [

                                                    { text: '   ONAY', alignment: "right", border: [true, false, true, true], margin: [1, 15, 1, 35] }
                                                ]
                                            ]
                                        },
                                        pageBreak: 'after'
                                    },

                                    { text: Olusturulma_Tar, alignment: "right", fontSize: 15, bold: true, margin: [5, 75, 10, 20] },
                                    { text: ' EDİS PHARMA İLAÇ SANAYİ ve TİC. LTD. ŞİRKETİ', alignment: "left", margin: [5, 15, 10, 20] },
                                    { text: 'SORUMLU BÖLGE MÜDÜRLÜĞÜ’NE ', alignment: "left", margin: [5, 1, 10, 20] },
                                    { text: 'Şahsıma zimmetli olarak kullandığım ' + Araç_Plaka+' plakalı şirket aracımı ', alignment: "left", margin: [5, 25, 1, 20] },
                                    { text: '' + İzin_Bas_Tar + ' - ' + İzin_Bit_Tar +'. tarihleri arasında şahsi kullanımım için izin talep ediyorum. ', alignment: "left", margin: [5, 1, 10, 20] },

                                    { text: 'Belirtilen tarihler arasında yaşanabilecek tüm masraf, zarar ve yasal cezaların tarafımdan', alignment: "left", margin: [5, 25, 10, 20] },
                                    { text: 'karşılanacağını kabul ve ikrar ederim. ', alignment: "left", margin: [5, 1, 10, 20] },
                                    { text: ' Ad- Soyadı : ' + AD + ' ' + Soyad , alignment: "left", margin: [5, 45, 10, 20] },
                                    { text: 'T.C Kimlik Numarası : ', alignment: "left", margin: [5, 1, 10, 20] },
                                    { text: 'İmza : ', alignment: "left", margin: [5, 1, 10, 20] },

                                ]

                            }


                            var Yol_İzinsiz = {
                                content: [
                                    { text: 'EDİS PHARMA İLAÇ SANAYİ VE TİC.LTD.ŞTİ. ', alignment: "center", fontSize: 15, bold: true },
                                    { text: 'Cumhuriyet Mah. Cumhuriyet Cad.No:11/1 ÇEKMEKÖY / İSTANBUL ', alignment: "center" },
                                    { text: 'YILLIK İZİN FORMU ', alignment: "center", margin: [5, 15, 10, 20] },

                                    {
                                        margin: [5, 15, 10, 20],
                                        table: {

                                            // headers are automatically repeated if the table spans over multiple pages
                                            // you can declare how many rows should be treated as headers
                                            headerRows: 1,
                                            widths: ['*', '*'],

                                            body: [
                                                [{ text: 'İzin İsteminde Bulunan Personelin ', alignment: "center", colSpan: 2 }, ''],
                                                ['Adı ve Soyadı', AD + ' ' + Soyad],
                                                ['Ünvanı ', Grup_Tam_Ad],
                                            ]
                                        }
                                    },

                                    {
                                        margin: [5, 45, 10, 20],
                                        table: {

                                            // headers are automatically repeated if the table spans over multiple pages
                                            // you can declare how many rows should be treated as headers
                                            headerRows: 1,
                                            widths: ['*', '*'],

                                            body: [
                                                [{ text: 'Kullanılacak İzin ', alignment: "center", colSpan: 2 }, ''],
                                                ['Süresi', Süre + ' GÜN'],
                                                [{ text: 'Başlangıç Tarihi', bold: true }, İzin_Bas_Tar],
                                                [{ text: 'Bitiş Tarihi ', bold: true }, İzin_Bit_Tar],
                                                [{ text: 'Göreve Başlayacağı Tarih', bold: true }, Göreve_Baslayacagı_Tarih],
                                                [{ text: 'İzinde Bulunacağı Açık Adres', bold: true }, İzinde_Bulunacağı_Acık_Adres],
                                                [{ text: 'Yol İzni', bold: true }, Yol_İzni_Yazı, ],
                                                [{ text: 'İmzası', bold: true, margin: [5, 15, 10, 20], },'' ],
                                                [{ text: 'Açıklama', bold: true }, Açıklama],


                                            ]
                                        }
                                    },
                                    {
                                        table: {
                                            widths: ['auto'],
                                            body: [
                                                [
                                                    { text: 'İlgili Personel    /   /2021 tarihinde izinden dönmüş ve    /   /2021 tarihinde görevine başlamıştır. ', border: [true, true, true, false] },

                                                ],
                                                [

                                                    { text: '   ONAY', alignment: "right", border: [true, false, true, true], margin: [1, 15, 1, 35] }
                                                ]
                                            ]
                                        }
                                    },



                                ]

                            }

                            if (Yol_İzni=="0") {
                                pdfMake.createPdf(Yol_İzinli).download();
                            }
                            else {
                                pdfMake.createPdf(Yol_İzinsiz).download();
                            }


                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });


             


                })

                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Masraf-Girisi.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        Kullanıcı_Adı = data.d;


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                $('#example').dataTable({

                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    dom: 'Blfrtip',
                    buttons: [
                       
                        {
                            extend: 'pdfHtml5',
                            title: function () {
                                return "Yıllık_İzin_Listesi" + "_" + Kullanıcı_Adı + "_" + TextBox2.val() + "_" + TextBox3.val();
                            },
                            pageSize: 'LEGAL',
                            titleAttr: 'PDF',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5, 6, 7,8]
                            },
                            customize: function (doc) {

                                doc.content.splice(0, 1);

                                var now = new Date();
                                var jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();

                                var logo = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAe0AAAFpCAYAAACxlXA1AAAACXBIWXMAAC4jAAAuIwF4pT92AAAgAElEQVR4nO3df2xc5Z3v8S9tZop/5JcJiSEkabBLfgC1WyctkJCQ7kL/iK9u2d7dghqpKr29fxBVUGn/2N4l6q3Sbe8fVyqoSv/otlTVpiKrK7a9WucPym4hCSmUxMXmRwisTTYJKeMQnF+2U9mRuPqezDGTOWdmzsycH89zzvslpbRjGtszZ+Zznuf5Pt/nGvmngf8lIt8VAABgtI/x8gAAYAdCGwAASxDaAABYgtAGAMAShDYAAJYgtAEAsAShDQCAJQhtAAAsQWgDAGAJQhsAAEsQ2gAAWILQBgDAEoQ2AACWILQBALAEoQ0AgCUIbQAALEFoAwBgCUIbAABLfEzmtX+SFwsAAPN9rK/lWkIbAAALMD0OAIAlCG0AACxBaAMAYAlCGwAASxDaAABYgtAGAMAShDYAAJaYwwsFIKi+JYvkoc5FkT5f20dOiExOeR4HQGgDqIMG9sO3d0X6lD1ZOCODhDbgi+lxAAAsQWgDAGAJQhsAAEsQ2gAAWIJCNACBbR8+6vwBkAxCG0Bwba3S194a6RM2ePa8yPSM53EAhDaAOuzqXh75lq91z/5BBsfOeB4HQGhfRRtHIBq+H8L5nPQtnO95OM2OTM/IJR1JwiwxzCDYjNkPcxDaJQ7f+3nPYwjHNbv3ev4eDewsP+ej5y7KxMxleX38ghybuCS/GT/Ph2OUijeJ2iDm9o65Mi+fk57rF6b3943A5MxlGTl3Ud6duCTHJy5daYTDNRsrQhtISNeCuc43doPjseKPMTb1Zzk8Ni7PFs7IE4UPaOnZjHxOdnYtlwe7ls4+32hcW26Oc72616y7VDL8/ln5xchJeeJkgQCPGKENGGZJ67WydeWNzp/HiyPyp0ZPyY4T7xHgQbW1ykDvKuc5RPQ0xB+/fqH8w7q18sujx2X7m6OEd0TYpw0YTkeIj/Wtlg/v3yJDX7xLHulaxktWxc41XTLRfzeBnQAdievoe+L+L8gDyzoz9/vHgdAGLOKMaO78tBT+6i9kV89qZ/oXRfmc7N+y3rnB0fBAcvT5f2pzn+xefxuvQsgIbcBCOoXujmh0ZAmRoS3r5e6li3kmDPLVVStkYMNnsv40hIrQBiymIxodWerIO8tbFnVERyW4mXSZghvL8BDaQAroyFu3zznTkRmbMtebFR3RwVx6Y6nFgWgeoQ2kiIZXoX+TtGSoac3eDT2ex2CeoY29vCohILSBlNFR99TWjZmoMtcKZf19YT5dvqDrZPMIbSCltMo87dW7D3ez/c0m3+P1ahqhDaRYqqt38zmqxS1zz028Xs0itIGU0+rdNAb3IzTvsI7udmCKvDmENpABGtxpmypf35GtE+LSQg9sQeMIbSAjdKo8TcVpt3XM8zwG823o7OBVagKhDWSIFqelZTsYzVTs1M1pa00htIGMObZlnf0NWGjUYS36wjeHZy9Gek5yYfJSZn5fmEn3Ne/f0Cubnjtk7SvU105o20xney6dPZ/1p6EhhHaMnh49JduHj2bm943b5MxlGTl30difT6cFTRll6FYpbUyy52TB8zUbfCofzfO47tk/eB7LMt1XHcURp2vzORn0PIogCG2khgZ27zO/N/7X0S0vG9tb5N7ORbJuSUdiHb1+dleP7Pn1ByLTM56vme7ujgWR/ISDY2c8j2XZcSq9jUNoAzHTYBgcE3li9KTzjXWq8B+7l8lfLlsSa4DrqH93zyrZduh1z9cAmIlCNCBhuranwdn5L/8uj774qlP7EBfndCyKuhAz9mo3jtAGDKKjbw3v7w8eddbo4zDQu4pLALAEoQ0YaMebo9I+cECG3z8b+Q/nFBox2gasQGgDppqccgrr9h77U+Q/IKNtwA6ENmC4/oOvyK/eOh7pD+mMtm1vuAKjaa2G3oBq3cb2kRO8WA2iehywgBaqLcjnItkz69rZtdyZlgfCMHruorw0Ni4DhTOyZ8zOrYUmIrQBS+iIe39+TmRnSH9zzScJbTRM6y8OFsblycIZ9rtHiNAGLLLp4JAU+jdFsp9b/07aSyII3dnwx9Pjsq8wLj8onOGaiRGhDdhkeka2HhyWw/d+PpIfWpu8bDvEBzCupuvRh8fG5dnCGXmi8IFTJIlkENqAZXTq8cCp05FMk2tXNqFDGoq0YGy7LpmwHm0MqscBC216+Y1Ifmhn2p0923DpiJrANgqhDdhociqy/ds7l9/geQyAGQhtwFL9Q29F8oNv7uzwPAbADIQ2YKvJKWcvbNg+u5jQBkxFaAMW+/Gbx0L/4fXITta1ATMR2oDFnjhZiOSHf6BjnucxAMkjtAGbTc9EMkV+d8cCz2MAkkdoA5Z75uTp0H+BDRSjAUYitAHLaa/nsLXn6LsEmIh3JmC5wQj6PnctmOt5LAt29azm7VDiwPg5+Y/py7MPDE5M0cI0YYR2jB6+vcv5Y7Nrdu/Nxotlk+kZpzd06IeIaAV5xj6gbX9/hu3hCn+fHhgycu6ivD5+QQ6Nn5efjl/g0JCYMD0OpEBh8lLov0Rfu7nbvqJYEkBwui2w5/qF8tVVK+TxOz8tU1s3SuGv/kIGNnzGOSkO0SG0gRTQc4yBJOlMz9aVNzoBPvTFu6RvySJejwgQ2gB8PdRp7oduFOv4CI+OwvX42P1b1ovkczyzISK0gRTQgqFM4eQpK+jxsYX+TUyZh4jQBlKgtMI3K4bfP8ulawGdNn//vjtojRsSQhuAlbRyGXbQwrWRLeuYKg8BoQ3A1+0dZu/VHqCC3Cq693/XGrbUNYvQBlJgcCz8AJtn+Khoz9gHnsdgNmcfPNPkTSG0Adhpekb2HvsTL55ldq+9OetPQVMIbQDW+u7ISV48y3zp5qVZfwqaQmgDsJYuC1BFbhctSntgWWfWn4aGEdpAGmS4KvfOl9/wPAaz9RvcuMd0hDaQAn0Zbl6hB1X85LVRz+Mw1x1LOK+9UYQ2AF829TPfPnyUojSLZPXo1zAQ2gBSof/gK/Krt47zYlqCA0UaQ2gDKfCpPEfjq22HXpcH9w0654vDbFyzjSG0gRS4u2MBL2PRnpMF6RzY76xzT85krye7LbhmG8OtTox0zY19pYjC/AhGLU/a3CZ0esZZ59Y/ur1o2/Ib5J6bFjvbjQCbcQXH6PjEpUjaTQK3dczL/HNQiY689Y+jrVUe6JjnjPK0t7q2au1eMJcwT4Dpve1NxZUKpEBnW0vov8TgxJTnMetNTske/eOGuA8KpLwO3/t5z2PNMr23vakIbcB2+ZxzZnHoJlMY2gEwGwaTUYgGWC6Kxiqj5y56HgOQPEIbsNxDEbSEnKDqGjASoQ1Y7ovLFof+C9jUDQ3IEkIbsFk+F0lLyAPj5zyPAUgeoQ1Y7JGIjjjcM37B8xiA5BHagMW+tWZl6D+80wI0o5XjgOkIbcBSup84iqnxt88yygZMRWgDlvpe97JIfvB9FKEBxiK0AQvpKHvryhsj+cF3nHjP8xgAMxDagIV+3ntLJD90Vtaz9aZn55ouz+OA6WhjClhGw6bn+oWR/ND/dnLM85jtWhbOl//RMU/Wd8yXO5Z0XFUHsOPNUS5/WIXQBiyiAfRY3+rIfuBv2n50bPEUr/7ORc7JZ1Hd3ABJIbQBW+Rz8v59d0T2w+rU+KWz5z2PGyufkweWXOccs7mhs4MjNpEJXOGADfI5GbnvzkhD6enRU57HjJHPOQejaJ91PYf5loXzojnZDDAcoQ0YTqfEj21ZF3lIbR854XnMFB/+zX1cpsg8oXocMNsDyzqdKfGoA/vAqdN0QQMswEgbMFE+J/s39MrdS8M/wcvPt48c83kUgGkIbcAk+ZzsWtMlX1u9IraiquH3z8rg2BnP4wDMQ2gDJmhrlV3dy2MNa9c3ht72PGYarWyn8AwgtIHktLXKI53XyZeXd8Y2DV7OllF2YfISoY3ME0IbiI+2ztzY3iL3di6SdUs6jAghG0bZAD5CaAPNamuVvvbW2b/kSx3zpSOfk/n5OU5Xrs62FiNHiVoxzlo2YBdCO0YP397l/Mmqa3bvjfQ315aVH27b6nkcXpMzl2XTy294Hs8arpfkvDtxKau/elPYpw1k0I9eHbFqX/ZBzvhOneOEdkMIbSBjtPiM062QtPHpGV6DBhDaQIbotHjvC0PW/cIHxs95HoPdfjNu0eE0BiG0gQzZ/Pygle1K/x9TqakzOEHb3EYQ2kBGfH/wqLXV4lYdGYqadMaHXveNIbSBDNh77E/Wr2PrWjzS4Y+nKSxsFKENpJwGdv/BV6z/JakgT499vJYNI7SBFEtLYKu/PfGe5zHYaQevZcMIbSCl0hTYUlzX1oNDYLfRcxdZz24CoQ2k0E9eG01VYLt+OEyvdNv9+E3Obm8GoQ2kiFblPrhvULYPH03ly/rE6ElG2xbT105fQzSO0AZSQqur2wcOyJ6ThVS/pI8eome6rbYeHM76U9A0QhuwnI6uH33xVel95veZWCvUm5JfvXXc8zjMpks2nCrXPE75AiylYf3Lo8dlu+6/zlgf522HXpcF+ZxsXXmj52swjxZFpnXJJm6ENmCZLId1KS202z09I19dtcLzNZhDR9gEdngIbcASB06dlqdPFCjkKaEj7h+dKMjeDT2ypPVaz9eRHN3a9ZVDR5gSDxmhDRhKK20Pj43Ls4Uz8oQWl3GUoS8Nhc5/+Xd5pGuZfGvNSulaMNfvX0NMtCDyFyMnubmMCKENGEA/6C5Mz8hr4xflycKZKycg0YCiLhoSTlC0tcrO5TfIf1m+RLoXzJW2HB9zUdLlGu0lrq1JnU5nXLeR4moGIqCj5MLk1cdJvj5+Qc5PX3b+uwazGtTTqxhBh2tyyjkcZfaAlLZW6WtvlYc6Fzn/c0Nnx+y3a8/NYWReg05zT8xcuW7dG0spXsPcXMaP0C5xze69nscQHZ3W5DlH5CanZFD/uGurbBWGxdinDQCAJRhpAwhMt+6wfQdIDiNtAAAsQWgDAGCJZKbH8znpWzjf8zAAAEkyfUdHIqGtgX343s97HgcAIEnX/Po5o0Ob6XEAAIpa8jmjnwpCGwCAorWENgAACAOhDQCAJQhtAAAsQWgDAGAJQhsAAEsQ2gAAFDnNVQxGaAMA4DL8fHtCGwAASyQS2rOH0QMAgMAYaQMAICLD7581/mlILLQnZy57HgMAAJUlFtoj5y56HgMAICnvTlwy/rlPLLQvGF6hBwDIluOEdmWvjTPSBgCY4+2JSeNfjcRC24YnBwCQHS8w0q7MhicHAJAdNmxHnuN5JCalT85PXhuVJwvs3QYAxOt73ctk68obZWzqz1Y884mFttInaUnrtbKivYWGKwCA2K1ev9b5lm+fvWDFk59ocxX3SbrnpsWerwEAEKm2VulaMNf5DrYURyca2vsK484/23Jz5IFlnZ6vAwAQlZ3Lb5j9m21Zok00tH8z/tERaNtKnjwAAKL2YNfS2e9g+pGcrkRDu3QdmylyAEBsSqbGR7VDpyUNvxI/MMRt0M4UOQAgLru6l89+p5fGxq153hMP7YOFj56sh7uXeb4OAEDYvlwyNT5g0ZbjxEP7b0+8N/vf71662JmyAAAgKn1LFjnbjV17xj6w5rlOPLQvnT1/1TGdpVMWAACE7Xsls7rOEq1FB1gl2lzF9fy7p52ONFKcstg+fNTz70SurdWIG4bx6Rmnqt6pZAzrQgrwu2kv+CdGT3oej4Le5T7Uuajq36zbL0xouNOycL78nxo7G0z5WdWuntWex5LgPCcTUyKTU5F990e6lskt7W2ex9WB8XOy52TB83js8jnZtaar4nfdPnIi0ucoiCDvR50RvWRJdXVN+dxs3qh/PTFm7I/qx4jQ3n3ivdknUacs9M0YV4C4+tpb5eHbK7+54vRY8XvpHeD/PvJO0x8+QX43/V5xPef6ARHkuTYhCF/83K3Sc/1Cz+OlvrZ6hbT/+ndG3K2bcg27P4d2Pfzh8NuRXFtf715W8bV5WP9j32DiwT20ZX3Fn1Hcm5skQzufk70beq6aKvazobNDep/5vc9X7FN+E7WjZInWBolPj4vPesLXKUhz6Jv9qc19MrDhM56vIXq6m6HaB65Ldz5UG01lmYbB43d+Wkb6NzkBEaef3dWTaI2MznoEuX6SpNdtrcCW4meRDqbSQG+yXU6/8YRnOuplRGjrCOXAqdOz/1MvEJ2ywRU6C8F2uPg9vv7WwN/TGVlSRFmR7ofd3bOq0pcjoTdTI1vWxX6zIMUpZ1NmPSpqa70qwGr5Ts8tiTyXYdIbD70uXE+PnrLudzAjtPWkr5Grp89+tHal59/Jsu/rGwax2RlwBFJq/+eCh3wWfXXVitg/9PVmYWD9bZ7HI5XPyb57+ox/hQd6V10VYLXo+8H2GaXvlH2OOjUFljEmtHXtqbSKnO1fV3M691h+l2uNfE6+/enuun9avWaZIaqub+H8ql+Pgs5UxTm1O3LfnXWFYRL0Oi0txgrKGZlb+rms10DpjbjTBc2yqXExKbSlWEVeSu8E8ZEkPvCySKdxG/3Q/efiMX/wV6tKOSq6rt4Sw/tn9/rbZltjmuznvY3N3On7wtbP5fJR9o/fPOb5d2xg1O3gXx95R6ZK7v70TrDlyDvGbDXYe+xP8t2RcKtgP5Wf4xyW0shdLyLQ1nplGrdB+oGdxO6HoHR08ZVDR0L/e7+9vLOp5y0Ox7ask86B/ZFV+WvdienPgdRRYFmJflb1jZw0ZptjEOWjbPWECVsCG2BUaGs464dK6Z2qbrkxZavB8YlLoV+og8WlgYHimwHJGtrYW/X7a8HkZxd3VB2J/8O6tVc+EAxs2DAxczmSD9ttY2fk2MQleazPjH3ifvRDW7dgRfJ50tZ6pVrdArUKLPUad5Ynq9CReu8z9oR2+ShbB2A2NVQpZdT0uPhMWWSlkvyV8QuexxAvvc5qjUA2vfyG/PLocc/jpbK6BewHFvRv1tc39AY0+ZxTpV7tRs4U+rtXK7DULVCbDg7NHuRUiU1bwPyKSnVW11bGhbZOK5YWpEkT6y82KT1bHMnQJhPV/Oqt407hyvY3Rz3XaLksbgGzpWOWvjZhbqEcsGQdW28uam3x0kY4OgK98+U3PF8rZ8UWMJ+iUr0hsbm7m3GhrcpHMmna2A8z+a15ldKQ3jb81pVHpmc816gftoCZK6zGK3rd2LKspTcX1WYDdJTt1mJoqDlTyFXYsAVMf77y3/kXIdclxc3I0NaRTDldJ2TLEyKRz125vqpwQrpkDUyvUaebUhVsAUtOrcAJo/GKVqNXu25qTTHHqq215s3F1oPDV/3v/qG3PP9OOaO3gLV52zeX3pjYysjQ1g/H8jcdrSIRFb+78VL6RvfcSE7PXJlKrKHWlDuioUWjznJGFU01Xsnn5LUNPVWvmyBTzHGpVWCpNxieAsXJKc/ncDmTt4D5/c5B3rOmMzO0K9zl6V1THHstk7CxvSWVv5fxfO7Gy7nrfOX0jr3WaFunEHdm5WbTsJkwXc6o9fro6LOR16fWOrbeMJiybhqkwPIbQ/5hpp/Dteo3nC1ghs0o+W1rS8MoW0zb8nWV4l1e+ZSOSVvAwnRvQk0nXHqBf7htq+fxtKu17lzrja6Bro07qtFCmB2jJ3yDP02Ma/4zPSMrnzssU1s3er5USrepaeV70JDVkK821azbVmfrHwxQa7ZHP2c9o2zX5JSzNFTrxlabCnXrHngT5HO+2+/SMMoWo0O7eJf3YdmbQ8NF3zQ7fNa9o7aivSWSO0o9kL3ahwCioa9lrf2o5et85TTQtYq2WhGbTiFql7Vth173fC018jkjzwvQIP7+4NGa+8ffv++OQMer6kxftb9LR6W36zVT4++Ji992p3J+s5qldGlI166rLQWY1FTIr6NhWkbZYnpo612eTjOVdxlyRi56BmrMfWM1WAnX9Ki1ldB3nc+HBvvhez/v/UIJvYa36d7QhHsddy+YK0NfvMvzeBh/b7UP9STpDf7mzo6qN2j6s9dsvJLPOV3Vqvn7w0fM2U7ks92p3E9eG619TRZ3S9QabZvQVEhvxP260qVllC3Gh3ZxXepLNy+96gPBeYNt7K3+BkuhQYv3FppGRwW11vmCFhJpsGvA1/r7TLhm9b2T5BnPb09Meh6LgzYMKfRvqjrq1OdFe4dXmhHZv6G36v9fp5lNGs3VKrDUWQFPgWUFQUbbbrHw9uGjnq/FIp/zXQpI0yhbTC5Em1VhT6w7TZ4Vzok0KV8TjU0+52lrWE4/gOsZMVUq5CnFOfEiP02q819xfbsWHaX5NV7Rz5pqI3V9f/ZXCPtEBCiwLN/GWNX0jDOLUEuSTYW0ONDvpurRQ+ZU8YfB/NDWu7zho75VoLq2lNZq8nK2nkhjol0hrPOVc0fbtfiNBLJC38NJTh2769u1aBFT6eeK3mjZtI4tAQss6x0RB9ktEeR7R0FvtPyWLvU9ucfSg0EqsSK0pcrdku6VTHvTFdOm3azW1lqzlWOgdT4fQabTM7UFrEytor446Pq2HohRjU7zzn6u5HOy756+Kv+2YevYAQssG13jDfL/i72pUJXDWkzaKx+WygsUhtG7pb/zWTd0GyT0H3zFll8lML2r1TdJHIGtd6RxrbfqoQW1pu6ioo0gqq3L1bPOV85t/eh3x18qK1vAXHod6023KUc5Blnfdj9XbmpvqXq9aKGsaTfUtc5016n8Rn/mILslJOYtYFor4vcambRXPkze39RgvS8MyYf3b/H8gPoh+UjhTORvHg22g4Vxz+NhOzB+Tvbo2l/ClcZpo3f/tQJV3/wf/s19nsfDlPYtYHrjM3Luorw7cUmejeF9WbeA+7drXSvOfmzDXkMtsKzW9EWKNyRR92SIawuYFg76FVbqjaJJe+XDZFVoa4jp1KXfKE23G2iRS5R3VhrYiVVGomkmnRaX1BawIDMqAxs+E2hro4bz5ucHjRlB1yPo/u1K9HfvDlDYFqsAPfTjFPUWMF3H9tveJe5yakpnsqxZ03ZpaDqV1GWuWocCyvi1NUyaX29kE+hSU62e01J8z+n+dFvX6IOsb1fy338/bNxMWK0tXnGL8rwILRSstI6tr2nais9KWRfa6vYKBS06JaN7KYFyj68375hMk7eABQ1uKe7i0NG5jXR9O0hFdCldKzUuFAIUWCYhki1gVQ5r0RkQfU3TzMrQ1qktp8LXh1Yu7m705B6kkha+1SqcSYrJW8A0uB998VXP4350On2kf5N9M10B92+7TFzHlgAFlkkKewuYDswqrds7MyApL/C0MrSlyjS5FNcLtQgC0BAxcQTi0psJvakwlRYSBQ1u/SCduP8L1vVOCLp/28h17IAFlkkKcwuYDsgqbWdL+7S4y65CtDI6Ta6N/v3uMPXkpagL02A+3bbjd32UCtIUpVFBenLrTYWzzczQEYJbAVzrNDMprmPqe1L3LtvUWyBIf3IT17ElQIGlW80flSC1ImFsAdOBWKXCM13iSPu0uKv6p4nhNJB/9OpIxQpQ/fC4/rcvEdxZ1dZacwSi67ZR7vHXD5paYadBZ3qvATeAtSK41k2Ifl1/5/Ud863a1lZt/7aR69gBe+jrZ2SUpyIG6bvQ7BYwLSSt9j7aalhHuihZOz3uqlYBqh8ezqk8VJRnUpDq7HrbldZLP6SCjOT15sL0aWX9XfQmWEduQeioaP+W9fa8/6ZnfLu2mbqOrWr10NcRaNTHGOssUZBrwtmO1sC1UK1SXIodDG3cdtgo60NbalSA6l3zyH13EtwZo2totUYgOnqKY7ozyGEi6sUEejbXS2et6glunW7W958t69z64V9a5GrqOrYELLCM5UjK6RlnNF+L21SoHnrdVFoCleLSVtZ6Z6QitN0K0EofJDo1Q3BnS62qbL1W4uqYFPQwEb3J8DthyjT1Bre+//SD15YTzjQEtDBNw1ubxxjZmTBAgWWcR1LqaL7SwKmUsyYddAtYPlc1sPX6633ukOfxtEtHaBc/SKodHTcb3Ei9nQFO8arrWMIQaAveIEzcT+7HDe5KOzjKuY1YbNnVoSGk4W3qtGuQAstKhyxFJeioPlBToXzO+byu9jvq9ZfF44pTE9pSXHNzpjwrcA4BsLQJBALK55wDOapp5lCQhk1OBWpWYvoWsFIa3N2/fTFwcEuxAp33YHN0yrhWgWUSR1IGrd+o2VSoGNiV9mIr3YaY1QLjVIW20oKRaheOXux8aKRXkFaOzvpbAnfo/YdeDzSl7Ex7WlS8VW9wW9uIxRBBah+C1lGELej3rbh8FSCws35UcepCW+k6R7UPEYI7pdpaa249iaOatqLpmSvT8jW4W8Cs0UBw64eybq+yrRFL0oL00NdBS1LT+kHrN3RGybNUEiCw9e9O4zHM9bim77cvPT84dmazPT9yMLWqDsXdo6tbOTK4LgIAxggQ2HpTqDeHWf+8TuVIWwJWuDrTdFSVA0ByAgT27NY7BljpDW0JUFEubAcDgMTojKguk9QKbKdS3MStdwlIdWhLwAMPCG4AiJe7hFlte6Yb2LSi/kjqQ1vqCG4KYwAgerrlq1bNkdKZUgL7apkIbQmwh1uKFY16IRHcABANrRrXRjs1m8O8+Gqmt3ZVkpnQluIe7loNLvRCmtq60bsdAQDQFG0cVO20LheBXVmmQlvpHr8gnan0wrKlMxUAmE57Y9TqoyAEdk2ZC22pI7j1AnOasFCgBgCN0S1d/Ztqtl4VAjuQTIa21BHc7OUGgMYE2dLlIrCDyWxoSzG4S8/OrUQvuIn7v0CBGgAEpHVBtbZ0uQjs4DId2lI8O7fWdjApKVDTYx8BAJXtXn+bUxdUq0Jc92ET2PWp/oxmhHvBBKlqfKxvtWzu7JBNB4doqQcApdpaZWTLukDT4TROaUzmR9ouDe4H9w1W7VXuunvpYmedm+lyALhCTyCb6L+bwI4YoV1CD42vdciISy9MXa9huhxA1ul0+FOb+2pOh0vxtK72X/+OwG4QoV1GL//m/fkAAA1HSURBVKT2gQOBzgbWC1Sny/dvWU91OYDs0enw/k3y1VUrAv3qeh42x2s2h9D2MznlXFhBDnOX4nS5VpdrP10AyAKtDg86Ha50i23vM78nsJtEaFcyPeNcYEH2cktx1K39dHWaiFE3gNTK55zZxSDV4a7vDx51ttiieYR2DXqhBdkS5tJpIorUAKSRU2x2/xec2cUgtD5o3bN/kB1v1u6HgWAI7QC0srx17wuBCtSkWKSme7rpXQ4gFYqj66DFZuIWnA0ckMGxM56voXGEdkBOgdqvfxeoQM2lvcu1SIO1bgC2qnd0LcX1a6fgbHLK8zU0h9Cux/SMdA/sr3kudykddbPWDcA6ba11j66ldP2agrNIENoN0HO5gzZicelatzbO17tWADCZ9p/QyvB6RtdjU392lhFZv47WNX2/fen5wbEzm9P8S0amjpZ9pQ6cOi2bXn6DqSMARtEC2tc29DT2mUZr51gw0m6G7uce2B/opLBSzr7u/rspVANghnzOWcLTAtp6AltnG3U6fNNzhwjsmDDSDokWm+3d0BPoGLpSOqX06KE3nBaqABA3nQr/9qe761q3lmJ1+O0Hh2lHGjNCO0y6LWJDb13rQC7tvtb7whBT5gBioQONf16/tu6pcKWzi3qsMeJHaEdAi81+dldP3XeuUtwq0X/odaaaAERDq8I/d2tDgwudGVz53GFG1wliTTsCOtWte7q1OKNeW1fe6OyJdNa72SIGICzFdesP79/SUGDrVtfOgf0EdsIYaUesmVG33tX+cPhtpyMbADQkn5Nda7rka6tXNPQ5pGvXXzl0hM5mhiC046B3uD2rAh9fV47wBtAInbFrNKyFtWsjEdoxarTC3EV4AwhCj838Ts8tDX/WUBhrLkI7Ac3e/RLeAPw0G9a67/rvDx/hs8VghHZSmqjgdBHeAHT57ZFlnU2FtRQLzbYNv8XOFcMR2glrdspcCG8gm5osMHPpVPidL79BVbglCG1DNNqVqJSG99Ojp2S7NuznbhlIp7ZW2dW9vOmw5mbfToS2SZqsMnfputRv3jkl2468QyEJkBJ6mMf/XXuz08uhGfr58Mujx6kKtxShbaIQ1rtd2mHtuyMn2WMJWEp7Pfzd2pul5/qFTf8CrFvbj9A2mK53/7z3llDerNog4cdvHmMqDLBBPic7u5bLN9d8sql6F5fTHnnoLWbeUoDQtkCY4c3UOWCusKbAXRSZpQ+hbRGdJnt8/a2h3HlL8Q39i5GTjL6BJBW3bH1rzcqGTtzyo+/tbwy9zbJYChHaFmq2gUI5Rt9A/HQG7Xvdy+SemxY3VQVeirBOP0LbYmFOm7tm175PFihWAcLW1io7l98Q2lq1i7DODkI7BaIIb6VHi/5k5KRz1CiABhWnv7/evSz096gWmP31kXdYs84QQjtF3Om2sIpYXDp9/vy7p2X3ifcIcCAgrUF5uHtZKFs3y1ENnl2Edhq1tcpA76pQ18pc2kXp306OyTdHTnJ3D5TRoN62/IZI3nuzTVHoeJhphHaahbzXs5wG+OGxcUbgyLQog1rosYAyhHZGhNlVyc9VU+hjHzASQHoV16i/vLwzkqlvF90M4YfQzpq2Vtm99mb50s1LIxkVuLSIbV9hXHaceI91N1hPm578z85F8mDX0tD2UvuZPfRn5ATvG/gitLMqgoYOlbjr4AOFM0yjww75nDyw5Dpn2nvdko5IlpdKsVMDQRHaiG307XJH4T8onKGYDcbQ3RcPdS6SLy5bHPmNrDCqRoMIbVwlym0qfnQt/I+nxwlxxM6d8t7c2RHr9a61H6xVo1GENvwVK8+jXsMrR4gjKu5IekNnh3QvmBvLrJJLZ5eePlGg0yCaRmijtrZW2dW9XL7ctTTytT0/2qLxYGFcDoyfozIdwbS1ygMd86S/c5Hc1jEvsl0T1ehWradGT1GMiVAR2qiLTin+Y/cy+ctlSxIJcCnZH/7K+AX5zfh5phmzLp+TvoXznVH07R1z5ZaF8xK7NglqRI3QRsPcAL9jSUesU+h+9MPy6NmLcnzikjxZOCODOq3OiDx92lqlr73ViIB2EdSIE6GNcBRPL4p7DbwaXR8fOXfRmVp/e2JSXpi4xKjcFsXR85c65svK9hZnijvudehqZteoCx8Q1IgVoY3wlXSM+uziDmM+aF1umL8+fkHOT192RuZHpmcoekuAztaszeeckfOK9ha5qb3FqHB2XdWyl7oKJIjQRuS0avfbyzuNmEavRT+cC5OXZgNdi9/+Y/qyDE5MMaJqRHE6e2N7i9zS3mZ0MJfTAsh/PTHGLgYYhdBGvIqj8Hs7F8XSaSpsbqgrnXZX7tS7ysxaejGMlU5hd+Rzzn/X7VTKhlAud1XnPkbTMBShjWQV18K1wYWJU+nN0AKliZnLzt9wYXpGXhu/OPu3jU/POJXv5WJbcy+uGZfTaepSWuw1rxjInW0t1t1kVeNOeT9bOMPaNKxBaMMsba3ySOd11o7E41I64i9l4wg3LnoT9dLYuBwaP09Iwx5z26Rlzhz5b3NbZWHu44Q2DGdAkwzYp3TnAFsAYbRrPyEtLdfKXdd+Qm5tzcvauW3SnpsjK+e2Suucj3t+cm7JYbbJKdmjf0pOP3J7Rn+mY56sXjjX+OI2RE+LxrR4UEfRPx2/QOEYzDHn49Iyt11WzPm43DevVZa3XCudLZ+Qxdd+Qq5vydf9YxLasI5+IO8o+1DWCvXSPb2MyNOpdLseAQ1TtBTrQ77ZcWUA8bmO+dI25+Pyybmtof+EhDZSQQu4you49I30X9tb5O6OBU5B1Y1tLYzKLaKj53cnLn3U5Y5td0hK2bqyO4V968L4P08IbaSWjsD26J+SqXWxqKFHFpTviyeckYiydWV3CrvSunKS+JRC5miYD1bYXlUa6FKy75jp9sa409nuljd3qxsd6BCrsnXlBXPmyC3z2iKbwo4SoQ2U8AT68NVfd0Pd7fAlJcGu02VZmn7X6Wsp24NOBzkkxW9dWSUxhR0lQhuow0ehXvL/Gfb5/5c1LyntGiZlTUtccTcvKW3+4nLXkF2l3d6kwuwEEIviFHb5urKJU9hRIrSBKEzPXBVwYYadO9qvhFEurFScwi5fV250a1RaEdqAZdzRPmCb0ilsm9eVk0RoAwDCUbY1Kq3rykkitAEAwdTZchPhI7QBAFdU2BrFurI5CG0AyBC/rVGsK9uD0AaANDGo5SbCR2gDgE0qtNxkCjsbCG0AMEmFdWWmsCGENgAkoDiFnfaWmwgfoQ0AYaPlJiJCaANAvcqmsFlXRoj0NINzIjJU+s/exdc9L4Q2APij5SYiclxE/tPvT+/i6/6z1rcktAFkEy03EZ19FUbLQ81+R0IbQDpV2BrFujJC4E5hP1/8q5x/ulPYUSK0AdipwtYo1pURAncKe6h8xNy7+LpzST7BhDYAY9FyExE5XxbIs2vMQdaVk0RoA0hOhZabTGEjBPuKf8XzYa8rJ4nQBhCdCuvKTGEjBOVbo2JbV04SoQ2gKTqFTctNRKDS1qjE15WTRGgDqI6Wm4hG+bry7Pqy6evKSSK0gawrm8JmXRkhKl1Xdv9p/bpykghtIO1ouYno+LbczPoUdpQIbSAFaLmJiJwv3xJly9aotCK0ARtU2BrFujJCEFnLTYSP0AZMUGFrFOvKCEFiLTcRPkIbiAMtNxGd8q1RrCunGKENhMSv5aawNQrNs7blJsJHaANBVVhXZgobIUhly02Ej9AGXMUpbFpuIgK+W6NYV0a9CG1kCi03ERFabiIWhDbSpWwKm3VlhISWmzACoQ270HIT0fFrucnWKBiF0IZZaLmJ6Bwv3xLF1ijYhtBG7Py2RrGujBDQchOpR2gjfBW2RrGujBDQchOZRmijfrTcRHTKt0axrgyUILThVaHlJlPYCAEtN4EmENoZ5beuLGyNQvNouQlEiNBOq+IUNi03EQG/rVGsKwMxILRtRctNRIeWm4ChCG2DlU5hs66MENFyE7AUoZ0kWm4iGpVabjKFDViO0I4SLTcRneHSLVFsjQKygdBuRoWtUawrIwS03ATgQWjX4Lc1inVlhICWmwDqRmjTchPRKd0axboygKalP7QrtNxkChshoOUmgFjZH9oV1pWZwkYIaLkJwCh2hHZxCpuWmwhZpa1RrCsDMJIZoU3LTUSHlpsAUiOe0C6bwmZdGSGi5SaAzAgttGm5iYhUarnJFDaAzAke2rTcRHT2VRgtM4UNACU+Cu0KW6NYV0YIaLkJACGY87Oe7udFujfzZKIJtNwEgBjQEQ1BlG+NYl0ZABJAaMNFy00AMByhnR203AQAyxHa6VFpaxTrygCQEoS2PWi5CQAZR2ibhZabAICKCO14+bbcZAobABAEoR2u8+VbotgaBQAIC6FdP1puAgASQWh70XITAGCkLIZ2+dYo1pUBAFZIY2jTchMAkEq2hjYtNwEAmWNqaPtujWJdGQCQZUmFNi03AQCoU1ShTctNAABC1kxo+7XcZGsUAAARqRbax8u3RLE1CgCA5MwpGSmzNQoAAFOJyP8HN1lOx7cj7LgAAAAASUVORK5CYII=';



                                doc.pageMargins = [20, 150, 20, 30];

                                doc.defaultStyle.fontSize = 9;



                                doc.styles.tableHeader.fontSize = 7;

                                doc['header'] = (function () {
                                    return {
                                        columns: [
                                            {
                                                image: logo,
                                                width: 90,
                                                margin: [15, 0]
                                            },
                                            {
                                                alignment: 'center',
                                                italics: true,
                                                text: 'Yıllık İzin Listesi',
                                                fontSize: 18,
                                                absolutePosition: { x: 15, y: 30 }
                                            },
                                            {
                                                alignment: 'right',
                                                fontSize: 14,
                                                text: Kullanıcı_Adı + " " + TextBox2.val() + "/" + TextBox3.val()
                                            },

                                        ],
                                        margin: 20
                                    }
                                });
                                // Create a footer object with 2 columns
                                // Left side: report creation date
                                // Right side: current page and total pages
                                doc['footer'] = (function (page, pages) {
                                    return {
                                        columns: [
                                            {
                                                alignment: 'left',
                                                text: ['Created on: ', { text: jsDate.toString() }]
                                            },
                                            {
                                                alignment: 'right',
                                                text: ['page ', { text: page.toString() }, ' of ', { text: pages.toString() }]
                                            }
                                        ],
                                        margin: 20
                                    }
                                });
                                // Change dataTable layout (Table styling)
                                // To use predefined layouts uncomment the line below and comment the custom lines below
                                // doc.content[0].layout = 'lightHorizontalLines'; // noBorders , headerLineOnly
                                var objLayout = {};
                                objLayout['hLineWidth'] = function (i) { return .5; };
                                objLayout['vLineWidth'] = function (i) { return .5; };
                                objLayout['hLineColor'] = function (i) { return '#aaa'; };
                                objLayout['vLineColor'] = function (i) { return '#aaa'; };
                                objLayout['paddingLeft'] = function (i) { return 10; };
                                objLayout['paddingRight'] = function (i) { return 10; };
                                doc.content[0].layout = objLayout;
                            },
                            footer: true
                        }
                    ],




                    



                });

              
            }


        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="myModalLabel">Siparişi Oluştur</h4>

                    </div>
                    <div class="modal-body">
                        İşlem Onaylandıktan Sonra İzin Gününüzden Düşecektir. Talebi Göndermek İstediğinizden Eminmisiniz ?

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Talebi_Gönder_Modal" class="btn btn-primary">Talebi Gönder</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="box">
        <div class="box-body">

            <div class="row" style="padding-bottom: 20px">
                <div class="col-xs-12">
                    <div class="form-group" style="text-align: center">
                        <label>İzin İsteminde Bulunan Personelin</label>
                    </div>
                </div>
            </div>
            <div class="box-footer">
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Ad Soyad</label>
                            <input id="Ad_Soyad" type="text" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Ünvanı</label>
                            <input id="Unvan" type="text" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Geçen Yıldan Devreden İzin Süresi</label>
                            <input id="Gecen_Yıldan_Devreden_İzin_Süresi" type="text" class="form-control" disabled />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label style="">İçinde Bulunulan Yılda Hak Kazanılan İzin Süresi</label>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Toplam İzin Süresi</label>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Toplam İzinden İçinde Bulunulan Yılda Kullanılan İzin Süresi</label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <input id="İçinde_Bulunulan_Bulunulan_Yılda_Hak_Kazanılan_İzin_Süresi" type="text" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">

                            <input id="Toplam_İzin_Süresi" type="text" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">

                            <input id="Toplam_İzinden_İçinde_Bulunulan_Yılda_Kullanılan_İzin_Süresi" type="text" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group" style="text-align: center">
                            <label>Toplam İzinden Kalan Süre</label>
                            <input id="Toplam_İzinden_Kalan_Süre" type="text" class="form-control" style="text-align: center" disabled />
                        </div>
                    </div>
                </div>
            </div>
            <div class="box-footer">
                <div class="row" style="padding-top: 10px; padding-bottom: 0px">
                    <div class="col-xs-12">
                        <div class="form-group" style="text-align: center">
                            <label>Kullanılıcak İzin</label>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Süresi(Gün)</label>
                                <select id="Süresi_Gün" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Başlangıç Tarih</label>
                                <asp:TextBox ID="TextBox4" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Bitiş Tarhi</label>
                                <asp:TextBox ID="TextBox5" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Göreve Başlayacağı Tarih</label>
                                <asp:TextBox ID="TextBox6" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-10">
                            <div class="form-group">
                                <label>İzinde Bulunacağı Açık Adres</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-10">
                            <div class="form-group">
                                <input id="İzinde_Bulunacağı_Açık_Adres" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="col-xs-2">
                            <div class="form-group">
                                <div class="checkbox" style="margin-top: 4px">
                                    <label>
                                        <input id="Yol_İzni" type="checkbox" />
                                        Yol İznini 
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Açıklama</label>
                                <textarea id="Acıklama" class="form-control" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <button id="Talebi_Gönder" type="button" class="btn btn-block btn-info btn-lg">Talebi Gönder</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class=" box-footer">
                <div class="row" style="padding-top: 25px">
                    <div class="col-xs-5 ">
                        <label>Başlangıç Tarhi</label>
                    </div>
                    <div class="col-xs-5 ">
                        <label>Bitiş Tarhi</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-5 ">
                        <div class="form-group">
                            <asp:TextBox ID="TextBox2" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-5 ">
                        <div class="form-group">
                            <asp:TextBox ID="TextBox3" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-2 ">
                            <div class="form-group">
                                <input id="cal_set" type="button" class="btn btn-block btn-info" value="SET" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <div class="row">
                <div id="Tablo_Div" class="col-xs-12">
                </div>
            </div>
        </div>
    </div>
</asp:Content>

