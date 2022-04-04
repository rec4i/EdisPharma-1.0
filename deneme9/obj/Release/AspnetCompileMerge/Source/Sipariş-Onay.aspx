<%@ Page Title="" Language="C#" MasterPageFile="~/Dp.Master" AutoEventWireup="true" CodeBehind="Sipariş-Onay.aspx.cs" Inherits="deneme9.Sipariş_Onay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">




    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>



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
        .Acık_Mavi{
           background-color:rgba(73, 141, 224, 0.8);
        }
    </style>
    <script>
        // your custom ajax request here



        function ajaxRequest(params) {

            //var url = 'https://examples.wenzhixin.net.cn/examples/bootstrap_table/data'
            //$.get(url + '?' + $.param(params.data)).then(function (res) {
            //    params.success(res)
            //})
            console.log(params.data)


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

            var ilk = new Date(x.getFullYear(), x.getMonth() + 1, 0);

            var son = new Date(x.getFullYear(), x.getMonth(), 1);


            console.log($('#İletim_Durumu_Select').find('opiton:selected').attr('value'))
            $.ajax({
                url: '<%= ResolveUrl("Sipariş-Onay.aspx/Tablo_Verisi_Pagenatrion") %>',
                type: 'POST',
                async: false,
                dataType: "json",
                data: "{" +
                    "'Tar_1':'" + $('input[id*=TextBox2]').val() + "'," +
                    "'Tar_2':'" + $('input[id*=TextBox3]').val() + "'," +
                    "'offset':'" + params.data.offset + "'," +
                    "'search':'" + params.data.search + "'," +
                    "'sort':''," +
                    "'order':''," +
                    "'İletim_Durumu':'" + $('#İletim_Durmu_Filtre').find('option:selected').attr('value') + "'," +
                    "'limit':'" + params.data.limit + "'" +
                    "}",
                //data: {
                //    'offset': params.data.offset,
                //    'search': params.data.search == undefined ? "" : params.data.search,
                //    'sort':  params.data.sort == undefined ? "" : params.data.sort,
                //    'order':   params.data.order == undefined ? "" : params.data.order,
                //    'limit': params.data.limit
                //},
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp_ = JSON.parse(data.d)
                    var temp = []
                    console.log(temp_)
                    
                    for (i = 0; i < temp_.length; i++) {


                        var Onay_Label = '';
                        var sil_Label = '';
                        if (temp_[i].Onay_Durum == 0) {
                            Onay_Label = '<span class="label label-warning">Onay Bekleniyor</span>'
                            sil_Label = '<a style="font-size: 20px; " id="Siparişi_Kaldır" value="' + temp_[i].Sil + '"><i class="fa fa-trash-o"></i></a>';
                        }
                        if (temp_[i].Onay_Durum == 1) {
                            Onay_Label = '<span class="label label-info">İşleme Alındı</span>'

                        }

                        var Onaylanmadıya_Düştümü_Label = '';
                        if (temp_[i].Onaylanmadıya_Düştümü == 0) {
                            Onaylanmadıya_Düştümü_Label = '<span class="label label-warning">HAYIR</span>'
                        }
                        if (temp_[i].Onaylanmadıya_Düştümü == 1) {
                            Onaylanmadıya_Düştümü_Label = '<span class="label label-info">EVET</span>'

                        }

                        var Düzenlendimi_Label = '';
                        if (temp_[i].Düzenlendimi == 0) {
                            Düzenlendimi_Label = '<span class="label label-warning">HAYIR</span>'
                        }
                        if (temp_[i].Düzenlendimi == 1) {
                            Düzenlendimi_Label = '<span class="label label-info">EVET</span>'

                        }

                        var Sipariş_Tekrar_Gönderlidimi_Label = '';
                        if (temp_[i].Sipariş_Tekrar_Gönderlidimi == 0) {
                            Sipariş_Tekrar_Gönderlidimi_Label = '<span class="label label-warning">HAYIR</span>'

                        }
                        if (temp_[i].Sipariş_Tekrar_Gönderlidimi == 1) {
                            Sipariş_Tekrar_Gönderlidimi_Label = '<span class="label label-info">EVET</span>'

                        }


                        var İletim_Label = '';


                        if (temp_[i].İletim_Durum == 1) {
                            İletim_Label = '<span class="label label-info">Depoya İletildi</span>'
                        }
                        if (temp_[i].İletim_Durum == 2) {
                            İletim_Label = '<span class="label label-success">Depo Onayladı</span>'
                        }
                        if (temp_[i].İletim_Durum == 3) {
                            İletim_Label = '<span class="label label-warning">Sevkiyatta</span>'
                        }
                        if (temp_[i].İletim_Durum == 4) {
                            İletim_Label = '<span class="label label-success">Eczaneye Ulaştı</span>'
                        }
                        if (temp_[i].İletim_Durum == 5) {
                            İletim_Label = '<span class="label label-danger">Eczane Onaylamadı</span>'
                        }
                        if (temp_[i].İletim_Durum == 6) {
                            İletim_Label = '<span class="label label-warning">Güncelleme Bekleniyor</span>'
                        }
                        if (temp_[i].İletim_Durum == 7) {
                            İletim_Label = '<span class="label label-danger">Sipariş İptal Edildi</span>'
                        }

                        var Lansman_Siparişi = '';


                        if (temp_[i].Lansman_Siparişi == 1) {
                            Lansman_Siparişi = '<span Lansman_Siparişi="1" class="label label-info">Evet</span>'
                        }
                        if (temp_[i].Lansman_Siparişi == 2) {
                            Lansman_Siparişi = '<span Lansman_Siparişi="2" class="label label-success">Hayır</span>'
                        }
                      
                        row = {}
                        row['Kullanıcı'] = temp_[i].Kullanıcı_Ad_Soyad
                        row['Eczacı_Adı'] = temp_[i].Eczacı_Adı
                        row['Eczane_Adı'] = temp_[i].Eczane_Adı
                        row['Şehir'] = temp_[i].CityName
                        row['Brick'] = temp_[i].TownName
                        row['Depo'] = temp_[i].Depo
                        row['Tarih'] = temp_[i].Tar
                        row['Onay_Durumu'] = Onay_Label
                        row['İletim_Durumu'] = İletim_Label
                        row['Onaylanmadıya_Düştümü'] = Onaylanmadıya_Düştümü_Label
                        row['Sipariş_Tekrar_Gönderildimi'] = Sipariş_Tekrar_Gönderlidimi_Label
                        row['Düzenlendimi'] = Düzenlendimi_Label
                        row['Lansam_Siparişi'] = Lansman_Siparişi
                        row['Detay'] = '<button class="btn btn-warning btn-sm"  value="' + temp_[i].Siparis_Genel_Id + '" id="Sipariş_Detay_pagination" style="word-break: keep-all;"><i class="fa fa-file-text "></i> Düzenle</button>'

                        //Randevular
                        temp.push(row)
                    }


                    //if (temp.length > 0) {
                    //    veri = {
                    //        'rows': temp,
                    //        'total': temp_[0].Sorugdaki_Sayı,
                    //        'totalNotFiltered': temp_[0].Toplam_Sayı,
                    //    }
                    //    params.success(veri)
                    //}

                    if (temp.length > 0) {
                        veri = {
                            'rows': temp,
                            'total': temp_[0].Sorugdaki_Sayı,
                            'totalNotFiltered': temp_[0].Toplam_Sayı,
                        }
                        params.success(veri)
                    }
                    else {
                        veri = {
                            'rows': temp,
                            'total': 0,
                            'totalNotFiltered': 0,
                        }
                        params.success(veri)

                    }

                    console.log(veri)


                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

        }

    </script>
      <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.css">

    <script type="text/javascript">
        $(document).ready(function () {
            /*$('#İletim_Durmu_Filtre')*/
            // multiple="multiple"
            $("select[id=İletim_Durmu_Filtre]").attr('multiple','multiple')
            $("select[id=İletim_Durmu_Filtre]").select2({
                placeholder: "Durum Seçiniz Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },

            })
            var Liste = [];
            var Liste_Onaylanan = [];
            var Liste_Red = [];
            var Molad_Liste = [];
            var TextBox2 = $('input[id*=TextBox2]')
            var TextBox3 = $('input[id*=TextBox3]')
            var TextBox1 = $('input[id*=TextBox1]')
            var TextBox4 = $('input[id*=TextBox4]')
            var TextBox5 = $('input[id*=TextBox5]')
            var TextBox6 = $('input[id*=TextBox6]')
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

            var d = new Date(x.getFullYear(), x.getMonth() + 1, 0);
            TextBox3.attr('value', formatDate(d));
            TextBox4.attr('value', formatDate(d));
            TextBox6.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), x.getMonth(), 1);
            TextBox2.attr('value', formatDate(d));
            TextBox1.attr('value', formatDate(d));
            TextBox5.attr('value', formatDate(d));


            $Hasta_Listesi = $('#Tablo_Div_Siparişlerim_Siparişlerim_Pagenation')

            buildTable_Hasta_Listesi($Hasta_Listesi, 1, 1)

            function buildTable_Hasta_Listesi($el, cells, rows) {


                var i; var j; var row
                var columns = [];
                var data__ = [];

                columns.push({
                    field: 'Kullanıcı',
                    title: 'Kullanıcı',
                    sortable: true
                })
                columns.push({
                    field: 'Eczacı_Adı',
                    title: 'Eczacı Adı',
                    sortable: true
                })
                columns.push({
                    field: 'Eczane_Adı',
                    title: 'Eczane Adı',
                    sortable: true
                })
                columns.push({
                    field: 'Şehir',
                    title: 'Şehir',
                    sortable: true
                })

                columns.push({
                    field: 'Brick',
                    title: 'Brick',
                    values: 'asd',
                    sortable: true
                })

                columns.push({
                    field: 'Depo',
                    title: 'Depo',
                    sortable: true
                })
                columns.push({
                    field: 'Tarih',
                    title: 'Tarih',
                })
                columns.push({
                    field: 'Lansam_Siparişi',
                    title: 'Lansam Siparişi',
                })

                columns.push({
                    field: 'Onay_Durumu',
                    title: 'Onay Durumu',
                })
                columns.push({
                    field: 'İletim_Durumu',
                    title: 'İletim Durumu',
                })
                columns.push({
                    field: 'Onaylanmadıya_Düştümü',
                    title: 'Onaylanmadıya Düştümü',
                })
                columns.push({
                    field: 'Sipariş_Tekrar_Gönderildimi',
                    title: 'Sipariş Tekrar Gönderildimi',
                })
                columns.push({
                    field: 'Düzenlendimi',
                    title: 'Düzenlendimi',
                })
                columns.push({
                    field: 'Detay',
                    title: 'Detay',
                })

                $el.bootstrapTable('destroy')

                $el.bootstrapTable({
                    columns: columns,
                    sidePagination: "server",
                    pagination: true,
                    ajax: ajaxRequest,
                    clickToSelect: true,
                    rowStyle: function (row__, index) {
                        var classes = [
                            'Acık_Mavi',
                            'bg-green',
                            'bg-orange',
                            'bg-yellow',
                            'bg-red'
                        ]
                        console.log(row__.Lansam_Siparişi)
                        console.log($($.parseHTML(row__.Lansam_Siparişi)).val() )
                        if ($($.parseHTML(row__.Lansam_Siparişi)).attr('Lansman_Siparişi') == "1") {
                            console.log("asdsad")
                            return {
                                classes: classes[0]
                            }
                        }
                        return {
                            css: {
                            }
                        }
                    },

                    onPostBody: function () {
                        $('button[id=Sipariş_Detay_pagination]').click(function () {
                            var Ziyaret_Modal_Red = $('button[id=Ziyaret_Modal_Red]')
                            Ziyaret_Modal_Red.attr('value', $(this).attr("value"))
                            var Ziyaret_Modal_Onay = $('button[id=Ziyaret_Modal_Onay]')
                            Ziyaret_Modal_Onay.attr('value', $(this).attr("value"))

                            var Sipariş_Genel_Id_ = $(this).attr("value");

                            $.ajax({
                                url: 'Sipariş-Onay.aspx/Sipariş_Detay',
                                type: 'POST',
                                data: "{'Sipariş_ıd': '" + $(this).attr("value") + "'}",
                                async: true,
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                success: function (data) {
                                    var temp = JSON.parse(data.d)

                                    Molad_Liste = [];
                                    for (var i = 0; i < temp.length; i++) {


                                        var MyClass = {
                                            Urun_Adı: null,
                                            Adet: null,
                                            Mf_Adet: null,
                                            Toplam: null,
                                            Birim_Fiyat: null,
                                            Satış_Fiyat: null,
                                            Birim_Fiyat_Toplam: null,
                                            Normal_Toplam: null,
                                            Sipariş_Detay_Id: null,
                                            Sipariş_Genel_Id: null
                                        }

                                        MyClass.Urun_Adı = temp[i].Urun_Adı
                                        MyClass.Adet = temp[i].Adet
                                        MyClass.Mf_Adet = temp[i].Mf_Adet
                                        MyClass.Toplam = temp[i].Toplam
                                        MyClass.Birim_Fiyat = temp[i].Birim_Fiyat
                                        MyClass.Satış_Fiyat = temp[i].Satış_Fiyat
                                        MyClass.Birim_Fiyat_Toplam = temp[i].Birim_Fiyat_Toplam
                                        MyClass.Normal_Toplam = temp[i].Normal_Toplam
                                        MyClass.Sipariş_Detay_Id = temp[i].Sipariş_Detay_Id
                                        MyClass.Sipariş_Genel_Id = Sipariş_Genel_Id_


                                        Molad_Liste.push(MyClass);

                                    }



                                    Tabloyu_Doldur_Detay(Molad_Liste)

                                    $('#Ziyaret_Modal').modal('show');


                                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            })

                            return false;


                        })

                    }
                })




                //$el.bootstrapTable('hideColumn', '__type')

                //$el.bootstrapTable('hideColumn', 'Hasta_Id')

                //JSON.stringify($table.bootstrapTable('getSelections'))



            }



            function Tabloyu_Doldur(Liste_) {

                $('#Tablo_Div_Siparişlerim_Siparişlerim').empty();

                $('#Tablo_Div_Siparişlerim_Siparişlerim').append('<table id="example" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Kullanıcı</th>' +

                    '<th>Eczacı Adı</th>' +
                    '<th>Eczane Adı</th>' +
                    '<th>Şehir</th>' +
                    '<th>Brick</th>' +
                    '<th>Depo</th>' +
                    '<th>Tarih</th>' +
                    '<th>Onay Durumu</th>' +
                    '<th>İletim Durumu</th>' +
                    '<th>Onaylanmadıya Düştümü</th>' +
                    '<th>Sipariş Tekrar Gönderildimi</th>' +
                    '<th>Düzenlendimi</th>' +
                    '<th>Detay</th>' +


                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody">' +
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
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );




                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody]')


                    for (var i = 0; i < Liste_.length; i++) {

                        var Onay_Label = '';
                        var sil_Label = '';
                        if (Liste_[i].Onay_Durum == 0) {
                            Onay_Label = '<span class="label label-warning">Onay Bekleniyor</span>'
                            sil_Label = '<a style="font-size: 20px; " id="Siparişi_Kaldır" value="' + Liste_[i].Sil + '"><i class="fa fa-trash-o"></i></a>';
                        }
                        if (Liste_[i].Onay_Durum == 1) {
                            Onay_Label = '<span class="label label-info">İşleme Alındı</span>'

                        }

                        var Onaylanmadıya_Düştümü_Label = '';
                        if (Liste_[i].Onaylanmadıya_Düştümü == 0) {
                            Onaylanmadıya_Düştümü_Label = '<span class="label label-warning">HAYIR</span>'
                        }
                        if (Liste_[i].Onaylanmadıya_Düştümü == 1) {
                            Onaylanmadıya_Düştümü_Label = '<span class="label label-info">EVET</span>'

                        }

                        var Düzenlendimi_Label = '';
                        if (Liste_[i].Düzenlendimi == 0) {
                            Düzenlendimi_Label = '<span class="label label-warning">HAYIR</span>'
                        }
                        if (Liste_[i].Düzenlendimi == 1) {
                            Düzenlendimi_Label = '<span class="label label-info">EVET</span>'

                        }

                        var Sipariş_Tekrar_Gönderlidimi_Label = '';
                        if (Liste_[i].Sipariş_Tekrar_Gönderlidimi == 0) {
                            Sipariş_Tekrar_Gönderlidimi_Label = '<span class="label label-warning">HAYIR</span>'

                        }
                        if (Liste_[i].Sipariş_Tekrar_Gönderlidimi == 1) {
                            Sipariş_Tekrar_Gönderlidimi_Label = '<span class="label label-info">EVET</span>'

                        }


                        var İletim_Label = '';


                        if (Liste_[i].İletim_Durum == 1) {
                            İletim_Label = '<span class="label label-info">Depoya İletildi</span>'
                        }
                        if (Liste_[i].İletim_Durum == 2) {
                            İletim_Label = '<span class="label label-success">Depo Onayladı</span>'
                        }
                        if (Liste_[i].İletim_Durum == 3) {
                            İletim_Label = '<span class="label label-warning">Sevkiyatta</span>'
                        }
                        if (Liste_[i].İletim_Durum == 4) {
                            İletim_Label = '<span class="label label-success">Eczaneye Ulaştı</span>'
                        }
                        if (Liste_[i].İletim_Durum == 5) {
                            İletim_Label = '<span class="label label-danger">Eczane Onaylamadı</span>'
                        }
                        if (Liste_[i].İletim_Durum == 6) {
                            İletim_Label = '<span class="label label-warning">Güncelleme Bekleniyor</span>'
                        }
                        if (Liste_[i].İletim_Durum == 7) {
                            İletim_Label = '<span class="label label-danger">Sipariş İptal Edildi</span>'
                        }

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Kullanıcı_Ad_Soyad + '</td>' +
                            '<td>' + Liste_[i].Eczacı_Adı + '</td>' +
                            '<td>' + Liste_[i].Eczane_Adı + '</td>' +
                            '<td>' + Liste_[i].Şehir + '</td>' +
                            '<td>' + Liste_[i].Brick + '</td>' +
                            '<td>' + Liste_[i].Depo + '</td>' +
                            '<td>' + Liste_[i].Tar + '</td>' +
                            '<td>' + Onay_Label + '</td>' +
                            '<td>' + İletim_Label + '</td>' +
                            '<td>' + Onaylanmadıya_Düştümü_Label + '</td>' +
                            '<td>' + Sipariş_Tekrar_Gönderlidimi_Label + '</td>' +
                            '<td>' + Düzenlendimi_Label + '</td>' +

                            '<td>' + '<a value="' + Liste_[i].Sil + '" id="Sipariş_Detay"><i class="fa fa fa-search"></i></a>' + '</td>' +
                            '</tr>'
                        )
                    }


                }





                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Sipariş-Onay.aspx/Kullanıcı_Adı_Soyadı',
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



                var today = new Date();
                var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
                var dateTime = date;

                $('#example').dataTable({
                    "order": [[4, "desc"]],
                    'columnDefs': [
                        {
                            "targets": 0, // your case first column
                            "className": "text-center",
                            "width": "10%"
                        },
                        {
                            "targets": 1, // your case first column
                            "className": "text-center",
                            "width": "10%"
                        },
                        {
                            "targets": 2, // your case first column
                            "className": "text-center",
                            "width": "10%"
                        },

                        {
                            "targets": 3, // your case first column
                            "className": "text-center",
                            "width": "10%"
                        },
                        {
                            "targets": 4, // your case first column
                            "className": "text-center",
                            "width": "7%"
                        },
                        {
                            "targets": 5, // your case first column
                            "className": "text-center",
                            "width": "7%"
                        },
                        {
                            "targets": 6, // your case first column
                            "className": "text-center",
                            "width": "7%"
                        },
                        {
                            "targets": 7, // your case first column
                            "className": "text-center",
                            "width": "7%"
                        },
                        {
                            "targets": 8, // your case first column
                            "className": "text-center",
                            "width": "7%"
                        },
                        {
                            "targets": 9, // your case first column
                            "className": "text-center",
                            "width": "7%"
                        }
                    ],



                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    dom: 'Blfrtip',
                    buttons: [
                        {
                            extend: 'excelHtml5',
                            title: function () {
                                return "Sipariş_Önizleme" + dateTime;
                            },
                            customize: function (xlsx) {
                                var sheet = xlsx.xl.worksheets['sheet1.xml'];

                                $('row c', sheet).attr('s', '55');

                            },

                        },
                        {

                            extend: 'pdfHtml5',
                            title: function () {
                                return "Sipariş_Önizleme" + dateTime;
                            },
                            pageSize: 'LEGAL',
                            titleAttr: 'PDF',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4]
                            },

                            customize: function (doc) {
                                doc.content[1].table.widths =
                                    Array(doc.content[1].table.body[0].length + 1).join('*').split('');

                                doc.content.splice(0, 1);

                                var now = new Date();
                                var jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();

                                var logo = 'data:image/png;base64,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';



                                doc.pageMargins = [20, 150, 20, 30];

                                doc.defaultStyle.fontSize = 7;



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
                                                text: 'Sipariş Önizleme',
                                                fontSize: 18,
                                                absolutePosition: { x: 15, y: 30 }
                                            },
                                            {
                                                alignment: 'right',
                                                fontSize: 14,
                                                text: Kullanıcı_Adı + " " + dateTime
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
                    "scrollX": true,




                });

                var Siparişi_Kaldır = $('a[id=Siparişi_Kaldır]')
                var Siparişi_İptal_Talebi_Olustur = $('button[id=Siparişi_İptal_Talebi_Olustur]')
                Siparişi_Kaldır.click(function () {

                    $('#myModal').modal('show')
                    Siparişi_İptal_Talebi_Olustur.attr("value", $(this).attr("value"))

                })
                Siparişi_İptal_Talebi_Olustur.click(function () {
                    $.ajax({
                        url: 'Sipariş-Onay.aspx/Sipariş_İptal_Talep',
                        type: 'POST',
                        data: "{'Sipariş_Id': '" + $(this).attr("value") + "'}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            $('#myModal').modal('toggle');
                            $('#İşlem_Başarılı').modal('show');


                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                })


                var Sipariş_Detay = $('a[id=Sipariş_Detay]')
                Sipariş_Detay.click(function () {
                    var Ziyaret_Modal_Red = $('button[id=Ziyaret_Modal_Red]')
                    Ziyaret_Modal_Red.attr('value', $(this).attr("value"))
                    var Ziyaret_Modal_Onay = $('button[id=Ziyaret_Modal_Onay]')
                    Ziyaret_Modal_Onay.attr('value', $(this).attr("value"))

                    var Sipariş_Genel_Id_ = $(this).attr("value");

                    $.ajax({
                        url: 'Sipariş-Onay.aspx/Sipariş_Detay',
                        type: 'POST',
                        data: "{'Sipariş_ıd': '" + $(this).attr("value") + "'}",
                        async: true,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var temp = JSON.parse(data.d)

                            Molad_Liste = [];
                            for (var i = 0; i < temp.length; i++) {


                                var MyClass = {
                                    Urun_Adı: null,
                                    Adet: null,
                                    Mf_Adet: null,
                                    Toplam: null,
                                    Birim_Fiyat: null,
                                    Satış_Fiyat: null,
                                    Birim_Fiyat_Toplam: null,
                                    Normal_Toplam: null,
                                    Sipariş_Detay_Id: null,
                                    Sipariş_Genel_Id: null
                                }

                                MyClass.Urun_Adı = temp[i].Urun_Adı
                                MyClass.Adet = temp[i].Adet
                                MyClass.Mf_Adet = temp[i].Mf_Adet
                                MyClass.Toplam = temp[i].Toplam
                                MyClass.Birim_Fiyat = temp[i].Birim_Fiyat
                                MyClass.Satış_Fiyat = temp[i].Satış_Fiyat
                                MyClass.Birim_Fiyat_Toplam = temp[i].Birim_Fiyat_Toplam
                                MyClass.Normal_Toplam = temp[i].Normal_Toplam
                                MyClass.Sipariş_Detay_Id = temp[i].Sipariş_Detay_Id
                                MyClass.Sipariş_Genel_Id = Sipariş_Genel_Id_


                                Molad_Liste.push(MyClass);

                            }



                         /*   Tabloyu_Doldur_Detay(Molad_Liste)*/

                            $('#Ziyaret_Modal').modal('show');


                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    })



                })


            }







            //Tablo_Listesini_Doldur();
            //Tablo_Listesini_Doldur_Onaylanan();
            //Tablo_Listesini_Doldur_Red();

            //function Tablo_Listesini_Doldur_Red() {
            //    $.ajax({
            //        url: 'Sipariş-Onay.aspx/Tablo_Verisi_Red',
            //        type: 'POST',
            //        data: "{'Tar_1': '" + TextBox5.val() + "','Tar_2':'" + TextBox6.val() + "'}",
            //        async: false,
            //        dataType: "json",
            //        contentType: "application/json; charset=utf-8",
            //        success: function (data) {
            //            var temp = JSON.parse(data.d)
            //            Liste_Red = [];

            //            for (var i = 0; i < temp.length; i++) {

            //                var MyClass = {
            //                    Eczane_Adı: null,
            //                    Şehir: null,
            //                    Brick: null,
            //                    Tar: null,
            //                    Onay_Durum: null,
            //                    Detay: null,
            //                    Kullanıcı_Ad_Soyad: null,
            //                    Sil: null

            //                }

            //                MyClass.Eczane_Adı = temp[i].Eczane_Adı
            //                MyClass.Şehir = temp[i].CityName
            //                MyClass.Brick = temp[i].TownName
            //                MyClass.Tar = temp[i].Tar
            //                MyClass.Onay_Durum = temp[i].Onay_Durum
            //                MyClass.Detay = temp[i].Siparis_Genel_Id
            //                MyClass.Sil = temp[i].Siparis_Genel_Id
            //                MyClass.Kullanıcı_Ad_Soyad = temp[i].Kullanıcı_Ad_Soyad




            //                Liste_Red.push(MyClass);

            //            }
            //            Tabloyu_Doldur_Red(Liste_Red)





            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });
            //}

            //function Tablo_Listesini_Doldur_Onaylanan() {
            //    $.ajax({
            //        url: 'Sipariş-Onay.aspx/Tablo_Verisi_Onaylanan',
            //        type: 'POST',
            //        data: "{'Tar_1': '" + TextBox1.val() + "','Tar_2':'" + TextBox4.val() + "'}",
            //        async: false,
            //        dataType: "json",
            //        contentType: "application/json; charset=utf-8",
            //        success: function (data) {
            //            var temp = JSON.parse(data.d)
            //            Liste_Onaylanan = [];

            //            for (var i = 0; i < temp.length; i++) {

            //                var MyClass = {
            //                    Eczane_Adı: null,
            //                    Şehir: null,
            //                    Brick: null,
            //                    Tar: null,
            //                    Onay_Durum: null,
            //                    Detay: null,
            //                    Kullanıcı_Ad_Soyad: null,
            //                    Sil: null

            //                }

            //                MyClass.Eczane_Adı = temp[i].Eczane_Adı
            //                MyClass.Şehir = temp[i].CityName
            //                MyClass.Brick = temp[i].TownName
            //                MyClass.Tar = temp[i].Tar
            //                MyClass.Onay_Durum = temp[i].Onay_Durum
            //                MyClass.Detay = temp[i].Siparis_Genel_Id
            //                MyClass.Sil = temp[i].Siparis_Genel_Id

            //                MyClass.Kullanıcı_Ad_Soyad = temp[i].Kullanıcı_Ad_Soyad


            //                Liste_Onaylanan.push(MyClass);

            //            }
            //            Tabloyu_Doldur_Onaylanan(Liste_Onaylanan)





            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });
            //}
            //function Tablo_Listesini_Doldur() {
            //    $.ajax({
            //        url: 'Sipariş-Onay.aspx/Tablo_Verisi',
            //        type: 'POST',
            //        data: "{'Tar_1': '" + TextBox2.val() + "','Tar_2':'" + TextBox3.val() + "'}",
            //        async: false,
            //        dataType: "json",
            //        contentType: "application/json; charset=utf-8",
            //        success: function (data) {
            //            var temp = JSON.parse(data.d)
            //            Liste = [];

            //            for (var i = 0; i < temp.length; i++) {

            //                var MyClass = {
            //                    Eczane_Adı: null,
            //                    Şehir: null,
            //                    Brick: null,
            //                    Tar: null,
            //                    Onay_Durum: null,
            //                    Detay: null,
            //                    Kullanıcı_Ad_Soyad: null,
            //                    Sil: null,
            //                    İletim_Durum: null,
            //                    Onaylanmadıya_Düştümü: null,
            //                    Sipariş_Tekrar_Gönderlidimi: null,
            //                    Depo: null,
            //                    Eczacı_Adı: null,
            //                    Düzenlendimi: null,

            //                }

            //                MyClass.Eczane_Adı = temp[i].Eczane_Adı
            //                MyClass.Şehir = temp[i].CityName
            //                MyClass.Brick = temp[i].TownName
            //                MyClass.Tar = temp[i].Tar
            //                MyClass.Onay_Durum = temp[i].Onay_Durum
            //                MyClass.Detay = temp[i].Siparis_Genel_Id
            //                MyClass.Sil = temp[i].Siparis_Genel_Id
            //                MyClass.Kullanıcı_Ad_Soyad = temp[i].Kullanıcı_Ad_Soyad
            //                MyClass.İletim_Durum = temp[i].İletim_Durum
            //                MyClass.Onaylanmadıya_Düştümü = temp[i].Onaylanmadıya_Düştümü
            //                MyClass.Sipariş_Tekrar_Gönderlidimi = temp[i].Sipariş_Tekrar_Gönderlidimi
            //                MyClass.Depo = temp[i].Depo
            //                MyClass.Eczacı_Adı = temp[i].Eczacı_Adı
            //                MyClass.Düzenlendimi = temp[i].Düzenlendimi

            //                Liste.push(MyClass);

            //            }

            //          /*  Tabloyu_Doldur(Liste)*/




            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });
            //}
            //function Tabloyu_Doldur_Red(Liste_) {
            //    $('#Tablo_Div_Siparişlerim_red').empty();

            //    $('#Tablo_Div_Siparişlerim_red').append('<table id="example_Red" class="display" style="width: 100%">' +
            //        '<thead>' +
            //        '<tr>' +
            //        '<th>Kullanıcı</th>' +
            //        '<th>Eczane Adı</th>' +
            //        '<th>Şehir</th>' +
            //        '<th>Brick</th>' +
            //        '<th>Tarih</th>' +
            //        '<th>Onay Durumu</th>' +
            //        '<th>Detay</th>' +
            //        '</tr>' +
            //        '</thead>' +
            //        '<tbody id="Tbody_red">' +
            //        '</tbody>' +
            //        '<tfoot>' +
            //        ' <tr>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +

            //        '</tr>' +
            //        '</tfoot>' +
            //        '</table>'
            //    );




            //    if (Liste_.length > 0) {
            //        var Tbody = $('tbody[id=Tbody_red]')


            //        for (var i = 0; i < Liste_.length; i++) {

            //            var Onay_Label = '';
            //            if (Liste_[i].Onay_Durum == 0) {
            //                Onay_Label = '<span class="label label-warning">Onay Bekleniyor</span>'
            //            }
            //            if (Liste_[i].Onay_Durum == 1) {
            //                Onay_Label = '<span class="label label-info">Onaylandı</span>'

            //            }
            //            if (Liste_[i].Onay_Durum == 2) {
            //                Onay_Label = '<span class="label label-danger">Reddedildi</span>'

            //            }
            //            Tbody.append(
            //                '<tr>' +
            //                '<td>' + Liste_[i].Kullanıcı_Ad_Soyad + '</td>' +
            //                '<td>' + Liste_[i].Eczane_Adı + '</td>' +
            //                '<td>' + Liste_[i].Şehir + '</td>' +
            //                '<td>' + Liste_[i].Brick + '</td>' +
            //                '<td>' + Liste_[i].Tar + '</td>' +
            //                '<td>' + Onay_Label + '</td>' +
            //                '<td>' + '<a value="' + Liste_[i].Sil + '" id="Sipariş_Detay"><i class="fa fa fa-search"></i></a>' + '</td>' +

            //                '</tr>'
            //            )
            //        }


            //    }





            //    var Kullanıcı_Adı;
            //    $.ajax({
            //        url: 'Sipariş-Onay.aspx/Kullanıcı_Adı_Soyadı',
            //        type: 'POST',
            //        data: "{'parametre': ''}",
            //        async: false,
            //        dataType: "json",
            //        contentType: "application/json; charset=utf-8",
            //        success: function (data) {

            //            Kullanıcı_Adı = data.d;


            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });



            //    var today = new Date();
            //    var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
            //    var dateTime = date;

            //    $('#example_Red').dataTable({
            //        "order": [[4, "desc"]],
            //        'columnDefs': [
            //            {
            //                "targets": 4, // your case first column
            //                "className": "text-center",
            //                "width": "10%"
            //            },
            //            {
            //                "targets": 5, // your case first column
            //                "className": "text-center",
            //                "width": "7%"
            //            },

            //        ],



            //        "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
            //        "language": {
            //            "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
            //        },
            //        dom: 'Blfrtip',
            //        buttons: [
            //            {
            //                extend: 'excelHtml5',
            //                title: function () {
            //                    return "Sipariş_Reddedilen" + dateTime;
            //                },
            //                customize: function (xlsx) {
            //                    var sheet = xlsx.xl.worksheets['sheet1.xml'];

            //                    $('row c', sheet).attr('s', '55');

            //                },

            //            },
            //            {

            //                extend: 'pdfHtml5',
            //                title: function () {
            //                    return "Sipariş_Reddedilen" + dateTime;
            //                },
            //                pageSize: 'LEGAL',
            //                titleAttr: 'PDF',
            //                exportOptions: {
            //                    columns: [0, 1, 2, 3, 4]
            //                },

            //                customize: function (doc) {
            //                    doc.content[1].table.widths =
            //                        Array(doc.content[1].table.body[0].length + 1).join('*').split('');

            //                    doc.content.splice(0, 1);

            //                    var now = new Date();
            //                    var jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();

            //                    var logo = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAe0AAAFpCAYAAACxlXA1AAAACXBIWXMAAC4jAAAuIwF4pT92AAAgAElEQVR4nO3df2xc5Z3v8S9tZop/5JcJiSEkabBLfgC1WyctkJCQ7kL/iK9u2d7dghqpKr29fxBVUGn/2N4l6q3Sbe8fVyqoSv/otlTVpiKrK7a9WucPym4hCSmUxMXmRwisTTYJKeMQnF+2U9mRuPqezDGTOWdmzsycH89zzvslpbRjGtszZ+Zznuf5Pt/nGvmngf8lIt8VAABgtI/x8gAAYAdCGwAASxDaAABYgtAGAMAShDYAAJYgtAEAsAShDQCAJQhtAAAsQWgDAGAJQhsAAEsQ2gAAWILQBgDAEoQ2AACWILQBALAEoQ0AgCUIbQAALEFoAwBgCUIbAABLfEzmtX+SFwsAAPN9rK/lWkIbAAALMD0OAIAlCG0AACxBaAMAYAlCGwAASxDaAABYgtAGAMAShDYAAJaYwwsFIKi+JYvkoc5FkT5f20dOiExOeR4HQGgDqIMG9sO3d0X6lD1ZOCODhDbgi+lxAAAsQWgDAGAJQhsAAEsQ2gAAWIJCNACBbR8+6vwBkAxCG0Bwba3S194a6RM2ePa8yPSM53EAhDaAOuzqXh75lq91z/5BBsfOeB4HQGhfRRtHIBq+H8L5nPQtnO95OM2OTM/IJR1JwiwxzCDYjNkPcxDaJQ7f+3nPYwjHNbv3ev4eDewsP+ej5y7KxMxleX38ghybuCS/GT/Ph2OUijeJ2iDm9o65Mi+fk57rF6b3943A5MxlGTl3Ud6duCTHJy5daYTDNRsrQhtISNeCuc43doPjseKPMTb1Zzk8Ni7PFs7IE4UPaOnZjHxOdnYtlwe7ls4+32hcW26Oc72616y7VDL8/ln5xchJeeJkgQCPGKENGGZJ67WydeWNzp/HiyPyp0ZPyY4T7xHgQbW1ykDvKuc5RPQ0xB+/fqH8w7q18sujx2X7m6OEd0TYpw0YTkeIj/Wtlg/v3yJDX7xLHulaxktWxc41XTLRfzeBnQAdievoe+L+L8gDyzoz9/vHgdAGLOKMaO78tBT+6i9kV89qZ/oXRfmc7N+y3rnB0fBAcvT5f2pzn+xefxuvQsgIbcBCOoXujmh0ZAmRoS3r5e6li3kmDPLVVStkYMNnsv40hIrQBiymIxodWerIO8tbFnVERyW4mXSZghvL8BDaQAroyFu3zznTkRmbMtebFR3RwVx6Y6nFgWgeoQ2kiIZXoX+TtGSoac3eDT2ex2CeoY29vCohILSBlNFR99TWjZmoMtcKZf19YT5dvqDrZPMIbSCltMo87dW7D3ez/c0m3+P1ahqhDaRYqqt38zmqxS1zz028Xs0itIGU0+rdNAb3IzTvsI7udmCKvDmENpABGtxpmypf35GtE+LSQg9sQeMIbSAjdKo8TcVpt3XM8zwG823o7OBVagKhDWSIFqelZTsYzVTs1M1pa00htIGMObZlnf0NWGjUYS36wjeHZy9Gek5yYfJSZn5fmEn3Ne/f0Cubnjtk7SvU105o20xney6dPZ/1p6EhhHaMnh49JduHj2bm943b5MxlGTl30difT6cFTRll6FYpbUyy52TB8zUbfCofzfO47tk/eB7LMt1XHcURp2vzORn0PIogCG2khgZ27zO/N/7X0S0vG9tb5N7ORbJuSUdiHb1+dleP7Pn1ByLTM56vme7ujgWR/ISDY2c8j2XZcSq9jUNoAzHTYBgcE3li9KTzjXWq8B+7l8lfLlsSa4DrqH93zyrZduh1z9cAmIlCNCBhuranwdn5L/8uj774qlP7EBfndCyKuhAz9mo3jtAGDKKjbw3v7w8eddbo4zDQu4pLALAEoQ0YaMebo9I+cECG3z8b+Q/nFBox2gasQGgDppqccgrr9h77U+Q/IKNtwA6ENmC4/oOvyK/eOh7pD+mMtm1vuAKjaa2G3oBq3cb2kRO8WA2iehywgBaqLcjnItkz69rZtdyZlgfCMHruorw0Ni4DhTOyZ8zOrYUmIrQBS+iIe39+TmRnSH9zzScJbTRM6y8OFsblycIZ9rtHiNAGLLLp4JAU+jdFsp9b/07aSyII3dnwx9Pjsq8wLj8onOGaiRGhDdhkeka2HhyWw/d+PpIfWpu8bDvEBzCupuvRh8fG5dnCGXmi8IFTJIlkENqAZXTq8cCp05FMk2tXNqFDGoq0YGy7LpmwHm0MqscBC216+Y1Ifmhn2p0923DpiJrANgqhDdhociqy/ds7l9/geQyAGQhtwFL9Q29F8oNv7uzwPAbADIQ2YKvJKWcvbNg+u5jQBkxFaAMW+/Gbx0L/4fXITta1ATMR2oDFnjhZiOSHf6BjnucxAMkjtAGbTc9EMkV+d8cCz2MAkkdoA5Z75uTp0H+BDRSjAUYitAHLaa/nsLXn6LsEmIh3JmC5wQj6PnctmOt5LAt29azm7VDiwPg5+Y/py7MPDE5M0cI0YYR2jB6+vcv5Y7Nrdu/Nxotlk+kZpzd06IeIaAV5xj6gbX9/hu3hCn+fHhgycu6ivD5+QQ6Nn5efjl/g0JCYMD0OpEBh8lLov0Rfu7nbvqJYEkBwui2w5/qF8tVVK+TxOz8tU1s3SuGv/kIGNnzGOSkO0SG0gRTQc4yBJOlMz9aVNzoBPvTFu6RvySJejwgQ2gB8PdRp7oduFOv4CI+OwvX42P1b1ovkczyzISK0gRTQgqFM4eQpK+jxsYX+TUyZh4jQBlKgtMI3K4bfP8ulawGdNn//vjtojRsSQhuAlbRyGXbQwrWRLeuYKg8BoQ3A1+0dZu/VHqCC3Cq693/XGrbUNYvQBlJgcCz8AJtn+Khoz9gHnsdgNmcfPNPkTSG0Adhpekb2HvsTL55ldq+9OetPQVMIbQDW+u7ISV48y3zp5qVZfwqaQmgDsJYuC1BFbhctSntgWWfWn4aGEdpAGmS4KvfOl9/wPAaz9RvcuMd0hDaQAn0Zbl6hB1X85LVRz+Mw1x1LOK+9UYQ2AF829TPfPnyUojSLZPXo1zAQ2gBSof/gK/Krt47zYlqCA0UaQ2gDKfCpPEfjq22HXpcH9w0654vDbFyzjSG0gRS4u2MBL2PRnpMF6RzY76xzT85krye7LbhmG8OtTox0zY19pYjC/AhGLU/a3CZ0esZZ59Y/ur1o2/Ib5J6bFjvbjQCbcQXH6PjEpUjaTQK3dczL/HNQiY689Y+jrVUe6JjnjPK0t7q2au1eMJcwT4Dpve1NxZUKpEBnW0vov8TgxJTnMetNTske/eOGuA8KpLwO3/t5z2PNMr23vakIbcB2+ZxzZnHoJlMY2gEwGwaTUYgGWC6Kxiqj5y56HgOQPEIbsNxDEbSEnKDqGjASoQ1Y7ovLFof+C9jUDQ3IEkIbsFk+F0lLyAPj5zyPAUgeoQ1Y7JGIjjjcM37B8xiA5BHagMW+tWZl6D+80wI0o5XjgOkIbcBSup84iqnxt88yygZMRWgDlvpe97JIfvB9FKEBxiK0AQvpKHvryhsj+cF3nHjP8xgAMxDagIV+3ntLJD90Vtaz9aZn55ouz+OA6WhjClhGw6bn+oWR/ND/dnLM85jtWhbOl//RMU/Wd8yXO5Z0XFUHsOPNUS5/WIXQBiyiAfRY3+rIfuBv2n50bPEUr/7ORc7JZ1Hd3ABJIbQBW+Rz8v59d0T2w+rU+KWz5z2PGyufkweWXOccs7mhs4MjNpEJXOGADfI5GbnvzkhD6enRU57HjJHPOQejaJ91PYf5loXzojnZDDAcoQ0YTqfEj21ZF3lIbR854XnMFB/+zX1cpsg8oXocMNsDyzqdKfGoA/vAqdN0QQMswEgbMFE+J/s39MrdS8M/wcvPt48c83kUgGkIbcAk+ZzsWtMlX1u9IraiquH3z8rg2BnP4wDMQ2gDJmhrlV3dy2MNa9c3ht72PGYarWyn8AwgtIHktLXKI53XyZeXd8Y2DV7OllF2YfISoY3ME0IbiI+2ztzY3iL3di6SdUs6jAghG0bZAD5CaAPNamuVvvbW2b/kSx3zpSOfk/n5OU5Xrs62FiNHiVoxzlo2YBdCO0YP397l/Mmqa3bvjfQ315aVH27b6nkcXpMzl2XTy294Hs8arpfkvDtxKau/elPYpw1k0I9eHbFqX/ZBzvhOneOEdkMIbSBjtPiM062QtPHpGV6DBhDaQIbotHjvC0PW/cIHxs95HoPdfjNu0eE0BiG0gQzZ/Pygle1K/x9TqakzOEHb3EYQ2kBGfH/wqLXV4lYdGYqadMaHXveNIbSBDNh77E/Wr2PrWjzS4Y+nKSxsFKENpJwGdv/BV6z/JakgT499vJYNI7SBFEtLYKu/PfGe5zHYaQevZcMIbSCl0hTYUlzX1oNDYLfRcxdZz24CoQ2k0E9eG01VYLt+OEyvdNv9+E3Obm8GoQ2kiFblPrhvULYPH03ly/rE6ElG2xbT105fQzSO0AZSQqur2wcOyJ6ThVS/pI8eome6rbYeHM76U9A0QhuwnI6uH33xVel95veZWCvUm5JfvXXc8zjMpks2nCrXPE75AiylYf3Lo8dlu+6/zlgf522HXpcF+ZxsXXmj52swjxZFpnXJJm6ENmCZLId1KS202z09I19dtcLzNZhDR9gEdngIbcASB06dlqdPFCjkKaEj7h+dKMjeDT2ypPVaz9eRHN3a9ZVDR5gSDxmhDRhKK20Pj43Ls4Uz8oQWl3GUoS8Nhc5/+Xd5pGuZfGvNSulaMNfvX0NMtCDyFyMnubmMCKENGEA/6C5Mz8hr4xflycKZKycg0YCiLhoSTlC0tcrO5TfIf1m+RLoXzJW2HB9zUdLlGu0lrq1JnU5nXLeR4moGIqCj5MLk1cdJvj5+Qc5PX3b+uwazGtTTqxhBh2tyyjkcZfaAlLZW6WtvlYc6Fzn/c0Nnx+y3a8/NYWReg05zT8xcuW7dG0spXsPcXMaP0C5xze69nscQHZ3W5DlH5CanZFD/uGurbBWGxdinDQCAJRhpAwhMt+6wfQdIDiNtAAAsQWgDAGCJZKbH8znpWzjf8zAAAEkyfUdHIqGtgX343s97HgcAIEnX/Po5o0Ob6XEAAIpa8jmjnwpCGwCAorWENgAACAOhDQCAJQhtAAAsQWgDAGAJQhsAAEsQ2gAAFDnNVQxGaAMA4DL8fHtCGwAASyQS2rOH0QMAgMAYaQMAICLD7581/mlILLQnZy57HgMAAJUlFtoj5y56HgMAICnvTlwy/rlPLLQvGF6hBwDIluOEdmWvjTPSBgCY4+2JSeNfjcRC24YnBwCQHS8w0q7MhicHAJAdNmxHnuN5JCalT85PXhuVJwvs3QYAxOt73ctk68obZWzqz1Y884mFttInaUnrtbKivYWGKwCA2K1ev9b5lm+fvWDFk59ocxX3SbrnpsWerwEAEKm2VulaMNf5DrYURyca2vsK484/23Jz5IFlnZ6vAwAQlZ3Lb5j9m21Zok00tH8z/tERaNtKnjwAAKL2YNfS2e9g+pGcrkRDu3QdmylyAEBsSqbGR7VDpyUNvxI/MMRt0M4UOQAgLru6l89+p5fGxq153hMP7YOFj56sh7uXeb4OAEDYvlwyNT5g0ZbjxEP7b0+8N/vf71662JmyAAAgKn1LFjnbjV17xj6w5rlOPLQvnT1/1TGdpVMWAACE7Xsls7rOEq1FB1gl2lzF9fy7p52ONFKcstg+fNTz70SurdWIG4bx6Rmnqt6pZAzrQgrwu2kv+CdGT3oej4Le5T7Uuajq36zbL0xouNOycL78nxo7G0z5WdWuntWex5LgPCcTUyKTU5F990e6lskt7W2ex9WB8XOy52TB83js8jnZtaar4nfdPnIi0ucoiCDvR50RvWRJdXVN+dxs3qh/PTFm7I/qx4jQ3n3ivdknUacs9M0YV4C4+tpb5eHbK7+54vRY8XvpHeD/PvJO0x8+QX43/V5xPef6ARHkuTYhCF/83K3Sc/1Cz+OlvrZ6hbT/+ndG3K2bcg27P4d2Pfzh8NuRXFtf715W8bV5WP9j32DiwT20ZX3Fn1Hcm5skQzufk70beq6aKvazobNDep/5vc9X7FN+E7WjZInWBolPj4vPesLXKUhz6Jv9qc19MrDhM56vIXq6m6HaB65Ldz5UG01lmYbB43d+Wkb6NzkBEaef3dWTaI2MznoEuX6SpNdtrcCW4meRDqbSQG+yXU6/8YRnOuplRGjrCOXAqdOz/1MvEJ2ywRU6C8F2uPg9vv7WwN/TGVlSRFmR7ofd3bOq0pcjoTdTI1vWxX6zIMUpZ1NmPSpqa70qwGr5Ts8tiTyXYdIbD70uXE+PnrLudzAjtPWkr5Grp89+tHal59/Jsu/rGwax2RlwBFJq/+eCh3wWfXXVitg/9PVmYWD9bZ7HI5XPyb57+ox/hQd6V10VYLXo+8H2GaXvlH2OOjUFljEmtHXtqbSKnO1fV3M691h+l2uNfE6+/enuun9avWaZIaqub+H8ql+Pgs5UxTm1O3LfnXWFYRL0Oi0txgrKGZlb+rms10DpjbjTBc2yqXExKbSlWEVeSu8E8ZEkPvCySKdxG/3Q/efiMX/wV6tKOSq6rt4Sw/tn9/rbZltjmuznvY3N3On7wtbP5fJR9o/fPOb5d2xg1O3gXx95R6ZK7v70TrDlyDvGbDXYe+xP8t2RcKtgP5Wf4xyW0shdLyLQ1nplGrdB+oGdxO6HoHR08ZVDR0L/e7+9vLOp5y0Ox7ask86B/ZFV+WvdienPgdRRYFmJflb1jZw0ZptjEOWjbPWECVsCG2BUaGs464dK6Z2qbrkxZavB8YlLoV+og8WlgYHimwHJGtrYW/X7a8HkZxd3VB2J/8O6tVc+EAxs2DAxczmSD9ttY2fk2MQleazPjH3ifvRDW7dgRfJ50tZ6pVrdArUKLPUad5Ynq9CReu8z9oR2+ShbB2A2NVQpZdT0uPhMWWSlkvyV8QuexxAvvc5qjUA2vfyG/PLocc/jpbK6BewHFvRv1tc39AY0+ZxTpV7tRs4U+rtXK7DULVCbDg7NHuRUiU1bwPyKSnVW11bGhbZOK5YWpEkT6y82KT1bHMnQJhPV/Oqt407hyvY3Rz3XaLksbgGzpWOWvjZhbqEcsGQdW28uam3x0kY4OgK98+U3PF8rZ8UWMJ+iUr0hsbm7m3GhrcpHMmna2A8z+a15ldKQ3jb81pVHpmc816gftoCZK6zGK3rd2LKspTcX1WYDdJTt1mJoqDlTyFXYsAVMf77y3/kXIdclxc3I0NaRTDldJ2TLEyKRz125vqpwQrpkDUyvUaebUhVsAUtOrcAJo/GKVqNXu25qTTHHqq215s3F1oPDV/3v/qG3PP9OOaO3gLV52zeX3pjYysjQ1g/H8jcdrSIRFb+78VL6RvfcSE7PXJlKrKHWlDuioUWjznJGFU01Xsnn5LUNPVWvmyBTzHGpVWCpNxieAsXJKc/ncDmTt4D5/c5B3rOmMzO0K9zl6V1THHstk7CxvSWVv5fxfO7Gy7nrfOX0jr3WaFunEHdm5WbTsJkwXc6o9fro6LOR16fWOrbeMJiybhqkwPIbQ/5hpp/Dteo3nC1ghs0o+W1rS8MoW0zb8nWV4l1e+ZSOSVvAwnRvQk0nXHqBf7htq+fxtKu17lzrja6Bro07qtFCmB2jJ3yDP02Ma/4zPSMrnzssU1s3er5USrepaeV70JDVkK821azbVmfrHwxQa7ZHP2c9o2zX5JSzNFTrxlabCnXrHngT5HO+2+/SMMoWo0O7eJf3YdmbQ8NF3zQ7fNa9o7aivSWSO0o9kL3ahwCioa9lrf2o5et85TTQtYq2WhGbTiFql7Vth173fC018jkjzwvQIP7+4NGa+8ffv++OQMer6kxftb9LR6W36zVT4++Ji992p3J+s5qldGlI166rLQWY1FTIr6NhWkbZYnpo612eTjOVdxlyRi56BmrMfWM1WAnX9Ki1ldB3nc+HBvvhez/v/UIJvYa36d7QhHsddy+YK0NfvMvzeBh/b7UP9STpDf7mzo6qN2j6s9dsvJLPOV3Vqvn7w0fM2U7ks92p3E9eG619TRZ3S9QabZvQVEhvxP260qVllC3Gh3ZxXepLNy+96gPBeYNt7K3+BkuhQYv3FppGRwW11vmCFhJpsGvA1/r7TLhm9b2T5BnPb09Meh6LgzYMKfRvqjrq1OdFe4dXmhHZv6G36v9fp5lNGs3VKrDUWQFPgWUFQUbbbrHw9uGjnq/FIp/zXQpI0yhbTC5Em1VhT6w7TZ4Vzok0KV8TjU0+52lrWE4/gOsZMVUq5CnFOfEiP02q819xfbsWHaX5NV7Rz5pqI3V9f/ZXCPtEBCiwLN/GWNX0jDOLUEuSTYW0ONDvpurRQ+ZU8YfB/NDWu7zho75VoLq2lNZq8nK2nkhjol0hrPOVc0fbtfiNBLJC38NJTh2769u1aBFT6eeK3mjZtI4tAQss6x0RB9ktEeR7R0FvtPyWLvU9ucfSg0EqsSK0pcrdku6VTHvTFdOm3azW1lqzlWOgdT4fQabTM7UFrEytor446Pq2HohRjU7zzn6u5HOy756+Kv+2YevYAQssG13jDfL/i72pUJXDWkzaKx+WygsUhtG7pb/zWTd0GyT0H3zFll8lML2r1TdJHIGtd6RxrbfqoQW1pu6ioo0gqq3L1bPOV85t/eh3x18qK1vAXHod6023KUc5Blnfdj9XbmpvqXq9aKGsaTfUtc5016n8Rn/mILslJOYtYFor4vcambRXPkze39RgvS8MyYf3b/H8gPoh+UjhTORvHg22g4Vxz+NhOzB+Tvbo2l/ClcZpo3f/tQJV3/wf/s19nsfDlPYtYHrjM3Luorw7cUmejeF9WbeA+7drXSvOfmzDXkMtsKzW9EWKNyRR92SIawuYFg76FVbqjaJJe+XDZFVoa4jp1KXfKE23G2iRS5R3VhrYiVVGomkmnRaX1BawIDMqAxs+E2hro4bz5ucHjRlB1yPo/u1K9HfvDlDYFqsAPfTjFPUWMF3H9tveJe5yakpnsqxZ03ZpaDqV1GWuWocCyvi1NUyaX29kE+hSU62e01J8z+n+dFvX6IOsb1fy338/bNxMWK0tXnGL8rwILRSstI6tr2nais9KWRfa6vYKBS06JaN7KYFyj68375hMk7eABQ1uKe7i0NG5jXR9O0hFdCldKzUuFAIUWCYhki1gVQ5r0RkQfU3TzMrQ1qktp8LXh1Yu7m705B6kkha+1SqcSYrJW8A0uB998VXP4350On2kf5N9M10B92+7TFzHlgAFlkkKewuYDswqrds7MyApL/C0MrSlyjS5FNcLtQgC0BAxcQTi0psJvakwlRYSBQ1u/SCduP8L1vVOCLp/28h17IAFlkkKcwuYDsgqbWdL+7S4y65CtDI6Ta6N/v3uMPXkpagL02A+3bbjd32UCtIUpVFBenLrTYWzzczQEYJbAVzrNDMprmPqe1L3LtvUWyBIf3IT17ElQIGlW80flSC1ImFsAdOBWKXCM13iSPu0uKv6p4nhNJB/9OpIxQpQ/fC4/rcvEdxZ1dZacwSi67ZR7vHXD5paYadBZ3qvATeAtSK41k2Ifl1/5/Ud863a1lZt/7aR69gBe+jrZ2SUpyIG6bvQ7BYwLSSt9j7aalhHuihZOz3uqlYBqh8ezqk8VJRnUpDq7HrbldZLP6SCjOT15sL0aWX9XfQmWEduQeioaP+W9fa8/6ZnfLu2mbqOrWr10NcRaNTHGOssUZBrwtmO1sC1UK1SXIodDG3cdtgo60NbalSA6l3zyH13EtwZo2totUYgOnqKY7ozyGEi6sUEejbXS2et6glunW7W958t69z64V9a5GrqOrYELLCM5UjK6RlnNF+L21SoHnrdVFoCleLSVtZ6Z6QitN0K0EofJDo1Q3BnS62qbL1W4uqYFPQwEb3J8DthyjT1Bre+//SD15YTzjQEtDBNw1ubxxjZmTBAgWWcR1LqaL7SwKmUsyYddAtYPlc1sPX6633ukOfxtEtHaBc/SKodHTcb3Ei9nQFO8arrWMIQaAveIEzcT+7HDe5KOzjKuY1YbNnVoSGk4W3qtGuQAstKhyxFJeioPlBToXzO+byu9jvq9ZfF44pTE9pSXHNzpjwrcA4BsLQJBALK55wDOapp5lCQhk1OBWpWYvoWsFIa3N2/fTFwcEuxAp33YHN0yrhWgWUSR1IGrd+o2VSoGNiV9mIr3YaY1QLjVIW20oKRaheOXux8aKRXkFaOzvpbAnfo/YdeDzSl7Ex7WlS8VW9wW9uIxRBBah+C1lGELej3rbh8FSCws35UcepCW+k6R7UPEYI7pdpaa249iaOatqLpmSvT8jW4W8Cs0UBw64eybq+yrRFL0oL00NdBS1LT+kHrN3RGybNUEiCw9e9O4zHM9bim77cvPT84dmazPT9yMLWqDsXdo6tbOTK4LgIAxggQ2HpTqDeHWf+8TuVIWwJWuDrTdFSVA0ByAgT27NY7BljpDW0JUFEubAcDgMTojKguk9QKbKdS3MStdwlIdWhLwAMPCG4AiJe7hFlte6Yb2LSi/kjqQ1vqCG4KYwAgerrlq1bNkdKZUgL7apkIbQmwh1uKFY16IRHcABANrRrXRjs1m8O8+Gqmt3ZVkpnQluIe7loNLvRCmtq60bsdAQDQFG0cVO20LheBXVmmQlvpHr8gnan0wrKlMxUAmE57Y9TqoyAEdk2ZC22pI7j1AnOasFCgBgCN0S1d/Ztqtl4VAjuQTIa21BHc7OUGgMYE2dLlIrCDyWxoSzG4S8/OrUQvuIn7v0CBGgAEpHVBtbZ0uQjs4DId2lI8O7fWdjApKVDTYx8BAJXtXn+bUxdUq0Jc92ET2PWp/oxmhHvBBKlqfKxvtWzu7JBNB4doqQcApdpaZWTLukDT4TROaUzmR9ouDe4H9w1W7VXuunvpYmedm+lyALhCTyCb6L+bwI4YoV1CD42vdciISy9MXa9huhxA1ul0+FOb+2pOh0vxtK72X/+OwG4QoV1GL//m/fkAAA1HSURBVKT2gQOBzgbWC1Sny/dvWU91OYDs0enw/k3y1VUrAv3qeh42x2s2h9D2MznlXFhBDnOX4nS5VpdrP10AyAKtDg86Ha50i23vM78nsJtEaFcyPeNcYEH2cktx1K39dHWaiFE3gNTK55zZxSDV4a7vDx51ttiieYR2DXqhBdkS5tJpIorUAKSRU2x2/xec2cUgtD5o3bN/kB1v1u6HgWAI7QC0srx17wuBCtSkWKSme7rpXQ4gFYqj66DFZuIWnA0ckMGxM56voXGEdkBOgdqvfxeoQM2lvcu1SIO1bgC2qnd0LcX1a6fgbHLK8zU0h9Cux/SMdA/sr3kudykddbPWDcA6ba11j66ldP2agrNIENoN0HO5gzZicelatzbO17tWADCZ9p/QyvB6RtdjU392lhFZv47WNX2/fen5wbEzm9P8S0amjpZ9pQ6cOi2bXn6DqSMARtEC2tc29DT2mUZr51gw0m6G7uce2B/opLBSzr7u/rspVANghnzOWcLTAtp6AltnG3U6fNNzhwjsmDDSDokWm+3d0BPoGLpSOqX06KE3nBaqABA3nQr/9qe761q3lmJ1+O0Hh2lHGjNCO0y6LWJDb13rQC7tvtb7whBT5gBioQONf16/tu6pcKWzi3qsMeJHaEdAi81+dldP3XeuUtwq0X/odaaaAERDq8I/d2tDgwudGVz53GFG1wliTTsCOtWte7q1OKNeW1fe6OyJdNa72SIGICzFdesP79/SUGDrVtfOgf0EdsIYaUesmVG33tX+cPhtpyMbADQkn5Nda7rka6tXNPQ5pGvXXzl0hM5mhiC046B3uD2rAh9fV47wBtAInbFrNKyFtWsjEdoxarTC3EV4AwhCj838Ts8tDX/WUBhrLkI7Ac3e/RLeAPw0G9a67/rvDx/hs8VghHZSmqjgdBHeAHT57ZFlnU2FtRQLzbYNv8XOFcMR2glrdspcCG8gm5osMHPpVPidL79BVbglCG1DNNqVqJSG99Ojp2S7NuznbhlIp7ZW2dW9vOmw5mbfToS2SZqsMnfputRv3jkl2468QyEJkBJ6mMf/XXuz08uhGfr58Mujx6kKtxShbaIQ1rtd2mHtuyMn2WMJWEp7Pfzd2pul5/qFTf8CrFvbj9A2mK53/7z3llDerNog4cdvHmMqDLBBPic7u5bLN9d8sql6F5fTHnnoLWbeUoDQtkCY4c3UOWCusKbAXRSZpQ+hbRGdJnt8/a2h3HlL8Q39i5GTjL6BJBW3bH1rzcqGTtzyo+/tbwy9zbJYChHaFmq2gUI5Rt9A/HQG7Xvdy+SemxY3VQVeirBOP0LbYmFOm7tm175PFihWAcLW1io7l98Q2lq1i7DODkI7BaIIb6VHi/5k5KRz1CiABhWnv7/evSz096gWmP31kXdYs84QQjtF3Om2sIpYXDp9/vy7p2X3ifcIcCAgrUF5uHtZKFs3y1ENnl2Edhq1tcpA76pQ18pc2kXp306OyTdHTnJ3D5TRoN62/IZI3nuzTVHoeJhphHaahbzXs5wG+OGxcUbgyLQog1rosYAyhHZGhNlVyc9VU+hjHzASQHoV16i/vLwzkqlvF90M4YfQzpq2Vtm99mb50s1LIxkVuLSIbV9hXHaceI91N1hPm578z85F8mDX0tD2UvuZPfRn5ATvG/gitLMqgoYOlbjr4AOFM0yjww75nDyw5Dpn2nvdko5IlpdKsVMDQRHaiG307XJH4T8onKGYDcbQ3RcPdS6SLy5bHPmNrDCqRoMIbVwlym0qfnQt/I+nxwlxxM6d8t7c2RHr9a61H6xVo1GENvwVK8+jXsMrR4gjKu5IekNnh3QvmBvLrJJLZ5eePlGg0yCaRmijtrZW2dW9XL7ctTTytT0/2qLxYGFcDoyfozIdwbS1ygMd86S/c5Hc1jEvsl0T1ehWradGT1GMiVAR2qiLTin+Y/cy+ctlSxIJcCnZH/7K+AX5zfh5phmzLp+TvoXznVH07R1z5ZaF8xK7NglqRI3QRsPcAL9jSUesU+h+9MPy6NmLcnzikjxZOCODOq3OiDx92lqlr73ViIB2EdSIE6GNcBRPL4p7DbwaXR8fOXfRmVp/e2JSXpi4xKjcFsXR85c65svK9hZnijvudehqZteoCx8Q1IgVoY3wlXSM+uziDmM+aF1umL8+fkHOT192RuZHpmcoekuAztaszeeckfOK9ha5qb3FqHB2XdWyl7oKJIjQRuS0avfbyzuNmEavRT+cC5OXZgNdi9/+Y/qyDE5MMaJqRHE6e2N7i9zS3mZ0MJfTAsh/PTHGLgYYhdBGvIqj8Hs7F8XSaSpsbqgrnXZX7tS7ysxaejGMlU5hd+Rzzn/X7VTKhlAud1XnPkbTMBShjWQV18K1wYWJU+nN0AKliZnLzt9wYXpGXhu/OPu3jU/POJXv5WJbcy+uGZfTaepSWuw1rxjInW0t1t1kVeNOeT9bOMPaNKxBaMMsba3ySOd11o7E41I64i9l4wg3LnoT9dLYuBwaP09Iwx5z26Rlzhz5b3NbZWHu44Q2DGdAkwzYp3TnAFsAYbRrPyEtLdfKXdd+Qm5tzcvauW3SnpsjK+e2Suucj3t+cm7JYbbJKdmjf0pOP3J7Rn+mY56sXjjX+OI2RE+LxrR4UEfRPx2/QOEYzDHn49Iyt11WzPm43DevVZa3XCudLZ+Qxdd+Qq5vydf9YxLasI5+IO8o+1DWCvXSPb2MyNOpdLseAQ1TtBTrQ77ZcWUA8bmO+dI25+Pyybmtof+EhDZSQQu4you49I30X9tb5O6OBU5B1Y1tLYzKLaKj53cnLn3U5Y5td0hK2bqyO4V968L4P08IbaSWjsD26J+SqXWxqKFHFpTviyeckYiydWV3CrvSunKS+JRC5miYD1bYXlUa6FKy75jp9sa409nuljd3qxsd6BCrsnXlBXPmyC3z2iKbwo4SoQ2U8AT68NVfd0Pd7fAlJcGu02VZmn7X6Wsp24NOBzkkxW9dWSUxhR0lQhuow0ehXvL/Gfb5/5c1LyntGiZlTUtccTcvKW3+4nLXkF2l3d6kwuwEEIviFHb5urKJU9hRIrSBKEzPXBVwYYadO9qvhFEurFScwi5fV250a1RaEdqAZdzRPmCb0ilsm9eVk0RoAwDCUbY1Kq3rykkitAEAwdTZchPhI7QBAFdU2BrFurI5CG0AyBC/rVGsK9uD0AaANDGo5SbCR2gDgE0qtNxkCjsbCG0AMEmFdWWmsCGENgAkoDiFnfaWmwgfoQ0AYaPlJiJCaANAvcqmsFlXRoj0NINzIjJU+s/exdc9L4Q2APij5SYiclxE/tPvT+/i6/6z1rcktAFkEy03EZ19FUbLQ81+R0IbQDpV2BrFujJC4E5hP1/8q5x/ulPYUSK0AdipwtYo1pURAncKe6h8xNy7+LpzST7BhDYAY9FyExE5XxbIs2vMQdaVk0RoA0hOhZabTGEjBPuKf8XzYa8rJ4nQBhCdCuvKTGEjBOVbo2JbV04SoQ2gKTqFTctNRKDS1qjE15WTRGgDqI6Wm4hG+bry7Pqy6evKSSK0gawrm8JmXRkhKl1Xdv9p/bpykghtIO1ouYno+LbczPoUdpQIbSAFaLmJiJwv3xJly9aotCK0ARtU2BrFujJCEFnLTYSP0AZMUGFrFOvKCEFiLTcRPkIbiAMtNxGd8q1RrCunGKENhMSv5aawNQrNs7blJsJHaANBVVhXZgobIUhly02Ej9AGXMUpbFpuIgK+W6NYV0a9CG1kCi03ERFabiIWhDbSpWwKm3VlhISWmzACoQ270HIT0fFrucnWKBiF0IZZaLmJ6Bwv3xLF1ijYhtBG7Py2RrGujBDQchOpR2gjfBW2RrGujBDQchOZRmijfrTcRHTKt0axrgyUILThVaHlJlPYCAEtN4EmENoZ5beuLGyNQvNouQlEiNBOq+IUNi03EQG/rVGsKwMxILRtRctNRIeWm4ChCG2DlU5hs66MENFyE7AUoZ0kWm4iGpVabjKFDViO0I4SLTcRneHSLVFsjQKygdBuRoWtUawrIwS03ATgQWjX4Lc1inVlhICWmwDqRmjTchPRKd0axboygKalP7QrtNxkChshoOUmgFjZH9oV1pWZwkYIaLkJwCh2hHZxCpuWmwhZpa1RrCsDMJIZoU3LTUSHlpsAUiOe0C6bwmZdGSGi5SaAzAgttGm5iYhUarnJFDaAzAke2rTcRHT2VRgtM4UNACU+Cu0KW6NYV0YIaLkJACGY87Oe7udFujfzZKIJtNwEgBjQEQ1BlG+NYl0ZABJAaMNFy00AMByhnR203AQAyxHa6VFpaxTrygCQEoS2PWi5CQAZR2ibhZabAICKCO14+bbcZAobABAEoR2u8+VbotgaBQAIC6FdP1puAgASQWh70XITAGCkLIZ2+dYo1pUBAFZIY2jTchMAkEq2hjYtNwEAmWNqaPtujWJdGQCQZUmFNi03AQCoU1ShTctNAABC1kxo+7XcZGsUAAARqRbax8u3RLE1CgCA5MwpGSmzNQoAAFOJyP8HN1lOx7cj7LgAAAAASUVORK5CYII=';



            //                    doc.pageMargins = [20, 150, 20, 30];

            //                    doc.defaultStyle.fontSize = 7;



            //                    doc.styles.tableHeader.fontSize = 7;

            //                    doc['header'] = (function () {
            //                        return {
            //                            columns: [
            //                                {
            //                                    image: logo,
            //                                    width: 90,
            //                                    margin: [15, 0]
            //                                },
            //                                {
            //                                    alignment: 'center',
            //                                    italics: true,
            //                                    text: 'Sipariş Reddedilen',
            //                                    fontSize: 18,
            //                                    absolutePosition: { x: 15, y: 30 }
            //                                },
            //                                {
            //                                    alignment: 'right',
            //                                    fontSize: 14,
            //                                    text: Kullanıcı_Adı + " " + dateTime
            //                                },

            //                            ],
            //                            margin: 20
            //                        }
            //                    });
            //                    // Create a footer object with 2 columns
            //                    // Left side: report creation date
            //                    // Right side: current page and total pages
            //                    doc['footer'] = (function (page, pages) {
            //                        return {
            //                            columns: [
            //                                {
            //                                    alignment: 'left',
            //                                    text: ['Created on: ', { text: jsDate.toString() }]
            //                                },
            //                                {
            //                                    alignment: 'right',
            //                                    text: ['page ', { text: page.toString() }, ' of ', { text: pages.toString() }]
            //                                }
            //                            ],
            //                            margin: 20
            //                        }
            //                    });
            //                    // Change dataTable layout (Table styling)
            //                    // To use predefined layouts uncomment the line below and comment the custom lines below
            //                    // doc.content[0].layout = 'lightHorizontalLines'; // noBorders , headerLineOnly
            //                    var objLayout = {};
            //                    objLayout['hLineWidth'] = function (i) { return .5; };
            //                    objLayout['vLineWidth'] = function (i) { return .5; };
            //                    objLayout['hLineColor'] = function (i) { return '#aaa'; };
            //                    objLayout['vLineColor'] = function (i) { return '#aaa'; };
            //                    objLayout['paddingLeft'] = function (i) { return 10; };
            //                    objLayout['paddingRight'] = function (i) { return 10; };
            //                    doc.content[0].layout = objLayout;


            //                },
            //                footer: true
            //            }
            //        ],








            //    });
            //    var Siparişi_Kaldır = $('a[id=Siparişi_Kaldır]')
            //    var Siparişi_İptal_Talebi_Olustur = $('button[id=Siparişi_İptal_Talebi_Olustur]')
            //    Siparişi_Kaldır.click(function () {

            //        $('#myModal').modal('show')
            //        Siparişi_İptal_Talebi_Olustur.attr("value", $(this).attr("value"))

            //    })
            //    Siparişi_İptal_Talebi_Olustur.click(function () {
            //        $.ajax({
            //            url: 'Sipariş-Onay.aspx/Sipariş_İptal_Talep',
            //            type: 'POST',
            //            data: "{'Sipariş_Id': '" + $(this).attr("value") + "'}",
            //            async: false,
            //            dataType: "json",
            //            contentType: "application/json; charset=utf-8",
            //            success: function (data) {
            //                $('#myModal').modal('toggle');
            //                $('#İşlem_Başarılı').modal('show');


            //            },
            //            error: function () {

            //                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //            }
            //        });
            //    })



            //}



            //function Tabloyu_Doldur_Onaylanan(Liste_) {
            //    $('#Tablo_Div_Siparişlerim_Onaylanan').empty();

            //    $('#Tablo_Div_Siparişlerim_Onaylanan').append('<table id="example_Onaylanan" class="display" style="width: 100%">' +
            //        '<thead>' +
            //        '<tr>' +
            //        '<th>Kullanıcı</th>' +
            //        '<th>Eczane Adı</th>' +
            //        '<th>Şehir</th>' +
            //        '<th>Brick</th>' +
            //        '<th>Tarih</th>' +
            //        '<th>Onay Durumu</th>' +
            //        '<th>Detay</th>' +

            //        '</tr>' +
            //        '</thead>' +
            //        '<tbody id="Tbody_Onaylanan">' +
            //        '</tbody>' +
            //        '<tfoot>' +
            //        ' <tr>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '<th></th>' +
            //        '</tr>' +
            //        '</tfoot>' +
            //        '</table>'
            //    );




            //    if (Liste_.length > 0) {
            //        var Tbody = $('tbody[id=Tbody_Onaylanan]')


            //        for (var i = 0; i < Liste_.length; i++) {

            //            var Onay_Label = '';
            //            if (Liste_[i].Onay_Durum == 0) {
            //                Onay_Label = '<span class="label label-warning">Onay Bekleniyor</span>'
            //            }
            //            if (Liste_[i].Onay_Durum == 1) {
            //                Onay_Label = '<span class="label label-info">Onaylandı</span>'

            //            }
            //            if (Liste_[i].Onay_Durum == 2) {
            //                Onay_Label = '<span class="label label-danger">Reddedildi</span>'

            //            }
            //            Tbody.append(
            //                '<tr>' +
            //                '<td>' + Liste_[i].Kullanıcı_Ad_Soyad + '</td>' +
            //                '<td>' + Liste_[i].Eczane_Adı + '</td>' +
            //                '<td>' + Liste_[i].Şehir + '</td>' +
            //                '<td>' + Liste_[i].Brick + '</td>' +

            //                '<td>' + Liste_[i].Tar + '</td>' +
            //                '<td>' + Onay_Label + '</td>' +

            //                '<td>' + '<a value="' + Liste_[i].Sil + '" id="Sipariş_Detay"><i class="fa fa fa-search"></i></a>' + '</td>' +





            //                '</tr>'
            //            )
            //        }


            //    }





            //    var Kullanıcı_Adı;
            //    $.ajax({
            //        url: 'Sipariş-Onay.aspx/Kullanıcı_Adı_Soyadı',
            //        type: 'POST',
            //        data: "{'parametre': ''}",
            //        async: false,
            //        dataType: "json",
            //        contentType: "application/json; charset=utf-8",
            //        success: function (data) {

            //            Kullanıcı_Adı = data.d;


            //        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            //        error: function () {

            //            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //        }
            //    });



            //    var today = new Date();
            //    var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
            //    var dateTime = date;

            //    $('#example_Onaylanan').dataTable({
            //        "order": [[4, "desc"]],
            //        'columnDefs': [
            //            {
            //                "targets": 4, // your case first column
            //                "className": "text-center",
            //                "width": "10%"
            //            },
            //            {
            //                "targets": 5, // your case first column
            //                "className": "text-center",
            //                "width": "7%"
            //            },

            //        ],



            //        "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
            //        "language": {
            //            "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
            //        },
            //        dom: 'Blfrtip',
            //        buttons: [
            //            {
            //                extend: 'excelHtml5',
            //                title: function () {
            //                    return "Sipariş_Önizleme" + dateTime;
            //                },
            //                customize: function (xlsx) {
            //                    var sheet = xlsx.xl.worksheets['sheet1.xml'];

            //                    $('row c', sheet).attr('s', '55');

            //                },

            //            },
            //            {

            //                extend: 'pdfHtml5',
            //                title: function () {
            //                    return "Sipariş_Önizleme" + dateTime;
            //                },
            //                pageSize: 'LEGAL',
            //                titleAttr: 'PDF',
            //                exportOptions: {
            //                    columns: [0, 1, 2, 3, 4]
            //                },

            //                customize: function (doc) {
            //                    doc.content[1].table.widths =
            //                        Array(doc.content[1].table.body[0].length + 1).join('*').split('');

            //                    doc.content.splice(0, 1);

            //                    var now = new Date();
            //                    var jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();

            //                    var logo = 'data:image/png;base64,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';



            //                    doc.pageMargins = [20, 150, 20, 30];

            //                    doc.defaultStyle.fontSize = 7;



            //                    doc.styles.tableHeader.fontSize = 7;

            //                    doc['header'] = (function () {
            //                        return {
            //                            columns: [
            //                                {
            //                                    image: logo,
            //                                    width: 90,
            //                                    margin: [15, 0]
            //                                },
            //                                {
            //                                    alignment: 'center',
            //                                    italics: true,
            //                                    text: 'Sipariş Önizleme',
            //                                    fontSize: 18,
            //                                    absolutePosition: { x: 15, y: 30 }
            //                                },
            //                                {
            //                                    alignment: 'right',
            //                                    fontSize: 14,
            //                                    text: Kullanıcı_Adı + " " + dateTime
            //                                },

            //                            ],
            //                            margin: 20
            //                        }
            //                    });
            //                    // Create a footer object with 2 columns
            //                    // Left side: report creation date
            //                    // Right side: current page and total pages
            //                    doc['footer'] = (function (page, pages) {
            //                        return {
            //                            columns: [
            //                                {
            //                                    alignment: 'left',
            //                                    text: ['Created on: ', { text: jsDate.toString() }]
            //                                },
            //                                {
            //                                    alignment: 'right',
            //                                    text: ['page ', { text: page.toString() }, ' of ', { text: pages.toString() }]
            //                                }
            //                            ],
            //                            margin: 20
            //                        }
            //                    });
            //                    // Change dataTable layout (Table styling)
            //                    // To use predefined layouts uncomment the line below and comment the custom lines below
            //                    // doc.content[0].layout = 'lightHorizontalLines'; // noBorders , headerLineOnly
            //                    var objLayout = {};
            //                    objLayout['hLineWidth'] = function (i) { return .5; };
            //                    objLayout['vLineWidth'] = function (i) { return .5; };
            //                    objLayout['hLineColor'] = function (i) { return '#aaa'; };
            //                    objLayout['vLineColor'] = function (i) { return '#aaa'; };
            //                    objLayout['paddingLeft'] = function (i) { return 10; };
            //                    objLayout['paddingRight'] = function (i) { return 10; };
            //                    doc.content[0].layout = objLayout;


            //                },
            //                footer: true
            //            }
            //        ],








            //    });
            //    var Siparişi_Kaldır = $('a[id=Siparişi_Kaldır]')
            //    var Siparişi_İptal_Talebi_Olustur = $('button[id=Siparişi_İptal_Talebi_Olustur]')
            //    Siparişi_Kaldır.click(function () {

            //        $('#myModal').modal('show')
            //        Siparişi_İptal_Talebi_Olustur.attr("value", $(this).attr("value"))

            //    })
            //    Siparişi_İptal_Talebi_Olustur.click(function () {
            //        $.ajax({
            //            url: 'Sipariş-Onay.aspx/Sipariş_İptal_Talep',
            //            type: 'POST',
            //            data: "{'Sipariş_Id': '" + $(this).attr("value") + "'}",
            //            async: false,
            //            dataType: "json",
            //            contentType: "application/json; charset=utf-8",
            //            success: function (data) {
            //                $('#myModal').modal('toggle');
            //                $('#İşlem_Başarılı').modal('show');


            //            },
            //            error: function () {

            //                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

            //            }
            //        });
            //    })



            //}







            function Tabloyu_Doldur_Detay(Liste_) {

                $('#Tablo_Div_Siparişlerim_Detay').empty();
                $('#Tablo_Div_Siparişlerim_Detay').append('<table id="example_Detay" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Urun Adı</th>' +
                    '<th>Adet</th>' +
                    '<th>Mf Adet</th>' +
                    '<th>Toplam</th>' +
                    '<th>Birim Fiyat</th>' +
                    '<th>Satış Fiyatı</th>' +
                    '<th>Toplam Birim Fiyatı</th>' +
                    '<th>Toplam Satış Fiyatı</th>' +
                    '<th>Düzenle</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody_Detay">' +
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
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );





                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody_Detay]')

                    for (var i = 0; i < Liste_.length; i++) {
                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Urun_Adı + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Toplam + '</td>' +
                            '<td>' + Liste_[i].Birim_Fiyat.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Satış_Fiyat.replace(',', '.') + '</td>' +

                            '<td>' + Liste_[i].Birim_Fiyat_Toplam.replace(',', '.') + '</td>' +
                            '<td>' + Liste_[i].Normal_Toplam.replace(',', '.') + '</td>' +
                            '<td>' + '<a Sipariş_Detay_Id="' + Liste_[i].Sipariş_Detay_Id + '" Sipariş_Genel_Id="' + Liste_[i].Sipariş_Genel_Id + '" id="Sipariş_Detay_Düzenle"><i class="fa fa fa-search"></i></a>' + '</td>' +


                            '</tr>'
                        )
                    }


                }





                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Sipariş-Onay.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        Kullanıcı_Adı = data.d;


                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                var today = new Date();
                var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
                var dateTime = date;

                $('#example_Detay').dataTable({


                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    dom: 'Blfrtip',
                    buttons: [

                        {

                            extend: 'pdfHtml5',
                            title: function () {
                                return "Sipariş_Detay" + dateTime;
                            },
                            pageSize: 'LEGAL',
                            titleAttr: 'PDF',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5, 6, 7]
                            },

                            customize: function (doc) {
                                doc.content[1].table.widths =
                                    Array(doc.content[1].table.body[0].length + 1).join('*').split('');

                                doc.content.splice(0, 1);

                                var now = new Date();
                                var jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();

                                var logo = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAe0AAAFpCAYAAACxlXA1AAAACXBIWXMAAC4jAAAuIwF4pT92AAAgAElEQVR4nO3df2xc5Z3v8S9tZop/5JcJiSEkabBLfgC1WyctkJCQ7kL/iK9u2d7dghqpKr29fxBVUGn/2N4l6q3Sbe8fVyqoSv/otlTVpiKrK7a9WucPym4hCSmUxMXmRwisTTYJKeMQnF+2U9mRuPqezDGTOWdmzsycH89zzvslpbRjGtszZ+Zznuf5Pt/nGvmngf8lIt8VAABgtI/x8gAAYAdCGwAASxDaAABYgtAGAMAShDYAAJYgtAEAsAShDQCAJQhtAAAsQWgDAGAJQhsAAEsQ2gAAWILQBgDAEoQ2AACWILQBALAEoQ0AgCUIbQAALEFoAwBgCUIbAABLfEzmtX+SFwsAAPN9rK/lWkIbAAALMD0OAIAlCG0AACxBaAMAYAlCGwAASxDaAABYgtAGAMAShDYAAJaYwwsFIKi+JYvkoc5FkT5f20dOiExOeR4HQGgDqIMG9sO3d0X6lD1ZOCODhDbgi+lxAAAsQWgDAGAJQhsAAEsQ2gAAWIJCNACBbR8+6vwBkAxCG0Bwba3S194a6RM2ePa8yPSM53EAhDaAOuzqXh75lq91z/5BBsfOeB4HQGhfRRtHIBq+H8L5nPQtnO95OM2OTM/IJR1JwiwxzCDYjNkPcxDaJQ7f+3nPYwjHNbv3ev4eDewsP+ej5y7KxMxleX38ghybuCS/GT/Ph2OUijeJ2iDm9o65Mi+fk57rF6b3943A5MxlGTl3Ud6duCTHJy5daYTDNRsrQhtISNeCuc43doPjseKPMTb1Zzk8Ni7PFs7IE4UPaOnZjHxOdnYtlwe7ls4+32hcW26Oc72616y7VDL8/ln5xchJeeJkgQCPGKENGGZJ67WydeWNzp/HiyPyp0ZPyY4T7xHgQbW1ykDvKuc5RPQ0xB+/fqH8w7q18sujx2X7m6OEd0TYpw0YTkeIj/Wtlg/v3yJDX7xLHulaxktWxc41XTLRfzeBnQAdievoe+L+L8gDyzoz9/vHgdAGLOKMaO78tBT+6i9kV89qZ/oXRfmc7N+y3rnB0fBAcvT5f2pzn+xefxuvQsgIbcBCOoXujmh0ZAmRoS3r5e6li3kmDPLVVStkYMNnsv40hIrQBiymIxodWerIO8tbFnVERyW4mXSZghvL8BDaQAroyFu3zznTkRmbMtebFR3RwVx6Y6nFgWgeoQ2kiIZXoX+TtGSoac3eDT2ex2CeoY29vCohILSBlNFR99TWjZmoMtcKZf19YT5dvqDrZPMIbSCltMo87dW7D3ez/c0m3+P1ahqhDaRYqqt38zmqxS1zz028Xs0itIGU0+rdNAb3IzTvsI7udmCKvDmENpABGtxpmypf35GtE+LSQg9sQeMIbSAjdKo8TcVpt3XM8zwG823o7OBVagKhDWSIFqelZTsYzVTs1M1pa00htIGMObZlnf0NWGjUYS36wjeHZy9Gek5yYfJSZn5fmEn3Ne/f0Cubnjtk7SvU105o20xney6dPZ/1p6EhhHaMnh49JduHj2bm943b5MxlGTl30difT6cFTRll6FYpbUyy52TB8zUbfCofzfO47tk/eB7LMt1XHcURp2vzORn0PIogCG2khgZ27zO/N/7X0S0vG9tb5N7ORbJuSUdiHb1+dleP7Pn1ByLTM56vme7ujgWR/ISDY2c8j2XZcSq9jUNoAzHTYBgcE3li9KTzjXWq8B+7l8lfLlsSa4DrqH93zyrZduh1z9cAmIlCNCBhuranwdn5L/8uj774qlP7EBfndCyKuhAz9mo3jtAGDKKjbw3v7w8eddbo4zDQu4pLALAEoQ0YaMebo9I+cECG3z8b+Q/nFBox2gasQGgDppqccgrr9h77U+Q/IKNtwA6ENmC4/oOvyK/eOh7pD+mMtm1vuAKjaa2G3oBq3cb2kRO8WA2iehywgBaqLcjnItkz69rZtdyZlgfCMHruorw0Ni4DhTOyZ8zOrYUmIrQBS+iIe39+TmRnSH9zzScJbTRM6y8OFsblycIZ9rtHiNAGLLLp4JAU+jdFsp9b/07aSyII3dnwx9Pjsq8wLj8onOGaiRGhDdhkeka2HhyWw/d+PpIfWpu8bDvEBzCupuvRh8fG5dnCGXmi8IFTJIlkENqAZXTq8cCp05FMk2tXNqFDGoq0YGy7LpmwHm0MqscBC216+Y1Ifmhn2p0923DpiJrANgqhDdhociqy/ds7l9/geQyAGQhtwFL9Q29F8oNv7uzwPAbADIQ2YKvJKWcvbNg+u5jQBkxFaAMW+/Gbx0L/4fXITta1ATMR2oDFnjhZiOSHf6BjnucxAMkjtAGbTc9EMkV+d8cCz2MAkkdoA5Z75uTp0H+BDRSjAUYitAHLaa/nsLXn6LsEmIh3JmC5wQj6PnctmOt5LAt29azm7VDiwPg5+Y/py7MPDE5M0cI0YYR2jB6+vcv5Y7Nrdu/Nxotlk+kZpzd06IeIaAV5xj6gbX9/hu3hCn+fHhgycu6ivD5+QQ6Nn5efjl/g0JCYMD0OpEBh8lLov0Rfu7nbvqJYEkBwui2w5/qF8tVVK+TxOz8tU1s3SuGv/kIGNnzGOSkO0SG0gRTQc4yBJOlMz9aVNzoBPvTFu6RvySJejwgQ2gB8PdRp7oduFOv4CI+OwvX42P1b1ovkczyzISK0gRTQgqFM4eQpK+jxsYX+TUyZh4jQBlKgtMI3K4bfP8ulawGdNn//vjtojRsSQhuAlbRyGXbQwrWRLeuYKg8BoQ3A1+0dZu/VHqCC3Cq693/XGrbUNYvQBlJgcCz8AJtn+Khoz9gHnsdgNmcfPNPkTSG0Adhpekb2HvsTL55ldq+9OetPQVMIbQDW+u7ISV48y3zp5qVZfwqaQmgDsJYuC1BFbhctSntgWWfWn4aGEdpAGmS4KvfOl9/wPAaz9RvcuMd0hDaQAn0Zbl6hB1X85LVRz+Mw1x1LOK+9UYQ2AF829TPfPnyUojSLZPXo1zAQ2gBSof/gK/Krt47zYlqCA0UaQ2gDKfCpPEfjq22HXpcH9w0654vDbFyzjSG0gRS4u2MBL2PRnpMF6RzY76xzT85krye7LbhmG8OtTox0zY19pYjC/AhGLU/a3CZ0esZZ59Y/ur1o2/Ib5J6bFjvbjQCbcQXH6PjEpUjaTQK3dczL/HNQiY689Y+jrVUe6JjnjPK0t7q2au1eMJcwT4Dpve1NxZUKpEBnW0vov8TgxJTnMetNTske/eOGuA8KpLwO3/t5z2PNMr23vakIbcB2+ZxzZnHoJlMY2gEwGwaTUYgGWC6Kxiqj5y56HgOQPEIbsNxDEbSEnKDqGjASoQ1Y7ovLFof+C9jUDQ3IEkIbsFk+F0lLyAPj5zyPAUgeoQ1Y7JGIjjjcM37B8xiA5BHagMW+tWZl6D+80wI0o5XjgOkIbcBSup84iqnxt88yygZMRWgDlvpe97JIfvB9FKEBxiK0AQvpKHvryhsj+cF3nHjP8xgAMxDagIV+3ntLJD90Vtaz9aZn55ouz+OA6WhjClhGw6bn+oWR/ND/dnLM85jtWhbOl//RMU/Wd8yXO5Z0XFUHsOPNUS5/WIXQBiyiAfRY3+rIfuBv2n50bPEUr/7ORc7JZ1Hd3ABJIbQBW+Rz8v59d0T2w+rU+KWz5z2PGyufkweWXOccs7mhs4MjNpEJXOGADfI5GbnvzkhD6enRU57HjJHPOQejaJ91PYf5loXzojnZDDAcoQ0YTqfEj21ZF3lIbR854XnMFB/+zX1cpsg8oXocMNsDyzqdKfGoA/vAqdN0QQMswEgbMFE+J/s39MrdS8M/wcvPt48c83kUgGkIbcAk+ZzsWtMlX1u9IraiquH3z8rg2BnP4wDMQ2gDJmhrlV3dy2MNa9c3ht72PGYarWyn8AwgtIHktLXKI53XyZeXd8Y2DV7OllF2YfISoY3ME0IbiI+2ztzY3iL3di6SdUs6jAghG0bZAD5CaAPNamuVvvbW2b/kSx3zpSOfk/n5OU5Xrs62FiNHiVoxzlo2YBdCO0YP397l/Mmqa3bvjfQ315aVH27b6nkcXpMzl2XTy294Hs8arpfkvDtxKau/elPYpw1k0I9eHbFqX/ZBzvhOneOEdkMIbSBjtPiM062QtPHpGV6DBhDaQIbotHjvC0PW/cIHxs95HoPdfjNu0eE0BiG0gQzZ/Pygle1K/x9TqakzOEHb3EYQ2kBGfH/wqLXV4lYdGYqadMaHXveNIbSBDNh77E/Wr2PrWjzS4Y+nKSxsFKENpJwGdv/BV6z/JakgT499vJYNI7SBFEtLYKu/PfGe5zHYaQevZcMIbSCl0hTYUlzX1oNDYLfRcxdZz24CoQ2k0E9eG01VYLt+OEyvdNv9+E3Obm8GoQ2kiFblPrhvULYPH03ly/rE6ElG2xbT105fQzSO0AZSQqur2wcOyJ6ThVS/pI8eome6rbYeHM76U9A0QhuwnI6uH33xVel95veZWCvUm5JfvXXc8zjMpks2nCrXPE75AiylYf3Lo8dlu+6/zlgf522HXpcF+ZxsXXmj52swjxZFpnXJJm6ENmCZLId1KS202z09I19dtcLzNZhDR9gEdngIbcASB06dlqdPFCjkKaEj7h+dKMjeDT2ypPVaz9eRHN3a9ZVDR5gSDxmhDRhKK20Pj43Ls4Uz8oQWl3GUoS8Nhc5/+Xd5pGuZfGvNSulaMNfvX0NMtCDyFyMnubmMCKENGEA/6C5Mz8hr4xflycKZKycg0YCiLhoSTlC0tcrO5TfIf1m+RLoXzJW2HB9zUdLlGu0lrq1JnU5nXLeR4moGIqCj5MLk1cdJvj5+Qc5PX3b+uwazGtTTqxhBh2tyyjkcZfaAlLZW6WtvlYc6Fzn/c0Nnx+y3a8/NYWReg05zT8xcuW7dG0spXsPcXMaP0C5xze69nscQHZ3W5DlH5CanZFD/uGurbBWGxdinDQCAJRhpAwhMt+6wfQdIDiNtAAAsQWgDAGCJZKbH8znpWzjf8zAAAEkyfUdHIqGtgX343s97HgcAIEnX/Po5o0Ob6XEAAIpa8jmjnwpCGwCAorWENgAACAOhDQCAJQhtAAAsQWgDAGAJQhsAAEsQ2gAAFDnNVQxGaAMA4DL8fHtCGwAASyQS2rOH0QMAgMAYaQMAICLD7581/mlILLQnZy57HgMAAJUlFtoj5y56HgMAICnvTlwy/rlPLLQvGF6hBwDIluOEdmWvjTPSBgCY4+2JSeNfjcRC24YnBwCQHS8w0q7MhicHAJAdNmxHnuN5JCalT85PXhuVJwvs3QYAxOt73ctk68obZWzqz1Y884mFttInaUnrtbKivYWGKwCA2K1ev9b5lm+fvWDFk59ocxX3SbrnpsWerwEAEKm2VulaMNf5DrYURyca2vsK484/23Jz5IFlnZ6vAwAQlZ3Lb5j9m21Zok00tH8z/tERaNtKnjwAAKL2YNfS2e9g+pGcrkRDu3QdmylyAEBsSqbGR7VDpyUNvxI/MMRt0M4UOQAgLru6l89+p5fGxq153hMP7YOFj56sh7uXeb4OAEDYvlwyNT5g0ZbjxEP7b0+8N/vf71662JmyAAAgKn1LFjnbjV17xj6w5rlOPLQvnT1/1TGdpVMWAACE7Xsls7rOEq1FB1gl2lzF9fy7p52ONFKcstg+fNTz70SurdWIG4bx6Rmnqt6pZAzrQgrwu2kv+CdGT3oej4Le5T7Uuajq36zbL0xouNOycL78nxo7G0z5WdWuntWex5LgPCcTUyKTU5F990e6lskt7W2ex9WB8XOy52TB83js8jnZtaar4nfdPnIi0ucoiCDvR50RvWRJdXVN+dxs3qh/PTFm7I/qx4jQ3n3ivdknUacs9M0YV4C4+tpb5eHbK7+54vRY8XvpHeD/PvJO0x8+QX43/V5xPef6ARHkuTYhCF/83K3Sc/1Cz+OlvrZ6hbT/+ndG3K2bcg27P4d2Pfzh8NuRXFtf715W8bV5WP9j32DiwT20ZX3Fn1Hcm5skQzufk70beq6aKvazobNDep/5vc9X7FN+E7WjZInWBolPj4vPesLXKUhz6Jv9qc19MrDhM56vIXq6m6HaB65Ldz5UG01lmYbB43d+Wkb6NzkBEaef3dWTaI2MznoEuX6SpNdtrcCW4meRDqbSQG+yXU6/8YRnOuplRGjrCOXAqdOz/1MvEJ2ywRU6C8F2uPg9vv7WwN/TGVlSRFmR7ofd3bOq0pcjoTdTI1vWxX6zIMUpZ1NmPSpqa70qwGr5Ts8tiTyXYdIbD70uXE+PnrLudzAjtPWkr5Grp89+tHal59/Jsu/rGwax2RlwBFJq/+eCh3wWfXXVitg/9PVmYWD9bZ7HI5XPyb57+ox/hQd6V10VYLXo+8H2GaXvlH2OOjUFljEmtHXtqbSKnO1fV3M691h+l2uNfE6+/enuun9avWaZIaqub+H8ql+Pgs5UxTm1O3LfnXWFYRL0Oi0txgrKGZlb+rms10DpjbjTBc2yqXExKbSlWEVeSu8E8ZEkPvCySKdxG/3Q/efiMX/wV6tKOSq6rt4Sw/tn9/rbZltjmuznvY3N3On7wtbP5fJR9o/fPOb5d2xg1O3gXx95R6ZK7v70TrDlyDvGbDXYe+xP8t2RcKtgP5Wf4xyW0shdLyLQ1nplGrdB+oGdxO6HoHR08ZVDR0L/e7+9vLOp5y0Ox7ask86B/ZFV+WvdienPgdRRYFmJflb1jZw0ZptjEOWjbPWECVsCG2BUaGs464dK6Z2qbrkxZavB8YlLoV+og8WlgYHimwHJGtrYW/X7a8HkZxd3VB2J/8O6tVc+EAxs2DAxczmSD9ttY2fk2MQleazPjH3ifvRDW7dgRfJ50tZ6pVrdArUKLPUad5Ynq9CReu8z9oR2+ShbB2A2NVQpZdT0uPhMWWSlkvyV8QuexxAvvc5qjUA2vfyG/PLocc/jpbK6BewHFvRv1tc39AY0+ZxTpV7tRs4U+rtXK7DULVCbDg7NHuRUiU1bwPyKSnVW11bGhbZOK5YWpEkT6y82KT1bHMnQJhPV/Oqt407hyvY3Rz3XaLksbgGzpWOWvjZhbqEcsGQdW28uam3x0kY4OgK98+U3PF8rZ8UWMJ+iUr0hsbm7m3GhrcpHMmna2A8z+a15ldKQ3jb81pVHpmc816gftoCZK6zGK3rd2LKspTcX1WYDdJTt1mJoqDlTyFXYsAVMf77y3/kXIdclxc3I0NaRTDldJ2TLEyKRz125vqpwQrpkDUyvUaebUhVsAUtOrcAJo/GKVqNXu25qTTHHqq215s3F1oPDV/3v/qG3PP9OOaO3gLV52zeX3pjYysjQ1g/H8jcdrSIRFb+78VL6RvfcSE7PXJlKrKHWlDuioUWjznJGFU01Xsnn5LUNPVWvmyBTzHGpVWCpNxieAsXJKc/ncDmTt4D5/c5B3rOmMzO0K9zl6V1THHstk7CxvSWVv5fxfO7Gy7nrfOX0jr3WaFunEHdm5WbTsJkwXc6o9fro6LOR16fWOrbeMJiybhqkwPIbQ/5hpp/Dteo3nC1ghs0o+W1rS8MoW0zb8nWV4l1e+ZSOSVvAwnRvQk0nXHqBf7htq+fxtKu17lzrja6Bro07qtFCmB2jJ3yDP02Ma/4zPSMrnzssU1s3er5USrepaeV70JDVkK821azbVmfrHwxQa7ZHP2c9o2zX5JSzNFTrxlabCnXrHngT5HO+2+/SMMoWo0O7eJf3YdmbQ8NF3zQ7fNa9o7aivSWSO0o9kL3ahwCioa9lrf2o5et85TTQtYq2WhGbTiFql7Vth173fC018jkjzwvQIP7+4NGa+8ffv++OQMer6kxftb9LR6W36zVT4++Ji992p3J+s5qldGlI166rLQWY1FTIr6NhWkbZYnpo612eTjOVdxlyRi56BmrMfWM1WAnX9Ki1ldB3nc+HBvvhez/v/UIJvYa36d7QhHsddy+YK0NfvMvzeBh/b7UP9STpDf7mzo6qN2j6s9dsvJLPOV3Vqvn7w0fM2U7ks92p3E9eG619TRZ3S9QabZvQVEhvxP260qVllC3Gh3ZxXepLNy+96gPBeYNt7K3+BkuhQYv3FppGRwW11vmCFhJpsGvA1/r7TLhm9b2T5BnPb09Meh6LgzYMKfRvqjrq1OdFe4dXmhHZv6G36v9fp5lNGs3VKrDUWQFPgWUFQUbbbrHw9uGjnq/FIp/zXQpI0yhbTC5Em1VhT6w7TZ4Vzok0KV8TjU0+52lrWE4/gOsZMVUq5CnFOfEiP02q819xfbsWHaX5NV7Rz5pqI3V9f/ZXCPtEBCiwLN/GWNX0jDOLUEuSTYW0ONDvpurRQ+ZU8YfB/NDWu7zho75VoLq2lNZq8nK2nkhjol0hrPOVc0fbtfiNBLJC38NJTh2769u1aBFT6eeK3mjZtI4tAQss6x0RB9ktEeR7R0FvtPyWLvU9ucfSg0EqsSK0pcrdku6VTHvTFdOm3azW1lqzlWOgdT4fQabTM7UFrEytor446Pq2HohRjU7zzn6u5HOy756+Kv+2YevYAQssG13jDfL/i72pUJXDWkzaKx+WygsUhtG7pb/zWTd0GyT0H3zFll8lML2r1TdJHIGtd6RxrbfqoQW1pu6ioo0gqq3L1bPOV85t/eh3x18qK1vAXHod6023KUc5Blnfdj9XbmpvqXq9aKGsaTfUtc5016n8Rn/mILslJOYtYFor4vcambRXPkze39RgvS8MyYf3b/H8gPoh+UjhTORvHg22g4Vxz+NhOzB+Tvbo2l/ClcZpo3f/tQJV3/wf/s19nsfDlPYtYHrjM3Luorw7cUmejeF9WbeA+7drXSvOfmzDXkMtsKzW9EWKNyRR92SIawuYFg76FVbqjaJJe+XDZFVoa4jp1KXfKE23G2iRS5R3VhrYiVVGomkmnRaX1BawIDMqAxs+E2hro4bz5ucHjRlB1yPo/u1K9HfvDlDYFqsAPfTjFPUWMF3H9tveJe5yakpnsqxZ03ZpaDqV1GWuWocCyvi1NUyaX29kE+hSU62e01J8z+n+dFvX6IOsb1fy338/bNxMWK0tXnGL8rwILRSstI6tr2nais9KWRfa6vYKBS06JaN7KYFyj68375hMk7eABQ1uKe7i0NG5jXR9O0hFdCldKzUuFAIUWCYhki1gVQ5r0RkQfU3TzMrQ1qktp8LXh1Yu7m705B6kkha+1SqcSYrJW8A0uB998VXP4350On2kf5N9M10B92+7TFzHlgAFlkkKewuYDswqrds7MyApL/C0MrSlyjS5FNcLtQgC0BAxcQTi0psJvakwlRYSBQ1u/SCduP8L1vVOCLp/28h17IAFlkkKcwuYDsgqbWdL+7S4y65CtDI6Ta6N/v3uMPXkpagL02A+3bbjd32UCtIUpVFBenLrTYWzzczQEYJbAVzrNDMprmPqe1L3LtvUWyBIf3IT17ElQIGlW80flSC1ImFsAdOBWKXCM13iSPu0uKv6p4nhNJB/9OpIxQpQ/fC4/rcvEdxZ1dZacwSi67ZR7vHXD5paYadBZ3qvATeAtSK41k2Ifl1/5/Ud863a1lZt/7aR69gBe+jrZ2SUpyIG6bvQ7BYwLSSt9j7aalhHuihZOz3uqlYBqh8ezqk8VJRnUpDq7HrbldZLP6SCjOT15sL0aWX9XfQmWEduQeioaP+W9fa8/6ZnfLu2mbqOrWr10NcRaNTHGOssUZBrwtmO1sC1UK1SXIodDG3cdtgo60NbalSA6l3zyH13EtwZo2totUYgOnqKY7ozyGEi6sUEejbXS2et6glunW7W958t69z64V9a5GrqOrYELLCM5UjK6RlnNF+L21SoHnrdVFoCleLSVtZ6Z6QitN0K0EofJDo1Q3BnS62qbL1W4uqYFPQwEb3J8DthyjT1Bre+//SD15YTzjQEtDBNw1ubxxjZmTBAgWWcR1LqaL7SwKmUsyYddAtYPlc1sPX6633ukOfxtEtHaBc/SKodHTcb3Ei9nQFO8arrWMIQaAveIEzcT+7HDe5KOzjKuY1YbNnVoSGk4W3qtGuQAstKhyxFJeioPlBToXzO+byu9jvq9ZfF44pTE9pSXHNzpjwrcA4BsLQJBALK55wDOapp5lCQhk1OBWpWYvoWsFIa3N2/fTFwcEuxAp33YHN0yrhWgWUSR1IGrd+o2VSoGNiV9mIr3YaY1QLjVIW20oKRaheOXux8aKRXkFaOzvpbAnfo/YdeDzSl7Ex7WlS8VW9wW9uIxRBBah+C1lGELej3rbh8FSCws35UcepCW+k6R7UPEYI7pdpaa249iaOatqLpmSvT8jW4W8Cs0UBw64eybq+yrRFL0oL00NdBS1LT+kHrN3RGybNUEiCw9e9O4zHM9bim77cvPT84dmazPT9yMLWqDsXdo6tbOTK4LgIAxggQ2HpTqDeHWf+8TuVIWwJWuDrTdFSVA0ByAgT27NY7BljpDW0JUFEubAcDgMTojKguk9QKbKdS3MStdwlIdWhLwAMPCG4AiJe7hFlte6Yb2LSi/kjqQ1vqCG4KYwAgerrlq1bNkdKZUgL7apkIbQmwh1uKFY16IRHcABANrRrXRjs1m8O8+Gqmt3ZVkpnQluIe7loNLvRCmtq60bsdAQDQFG0cVO20LheBXVmmQlvpHr8gnan0wrKlMxUAmE57Y9TqoyAEdk2ZC22pI7j1AnOasFCgBgCN0S1d/Ztqtl4VAjuQTIa21BHc7OUGgMYE2dLlIrCDyWxoSzG4S8/OrUQvuIn7v0CBGgAEpHVBtbZ0uQjs4DId2lI8O7fWdjApKVDTYx8BAJXtXn+bUxdUq0Jc92ET2PWp/oxmhHvBBKlqfKxvtWzu7JBNB4doqQcApdpaZWTLukDT4TROaUzmR9ouDe4H9w1W7VXuunvpYmedm+lyALhCTyCb6L+bwI4YoV1CD42vdciISy9MXa9huhxA1ul0+FOb+2pOh0vxtK72X/+OwG4QoV1GL//m/fkAAA1HSURBVKT2gQOBzgbWC1Sny/dvWU91OYDs0enw/k3y1VUrAv3qeh42x2s2h9D2MznlXFhBDnOX4nS5VpdrP10AyAKtDg86Ha50i23vM78nsJtEaFcyPeNcYEH2cktx1K39dHWaiFE3gNTK55zZxSDV4a7vDx51ttiieYR2DXqhBdkS5tJpIorUAKSRU2x2/xec2cUgtD5o3bN/kB1v1u6HgWAI7QC0srx17wuBCtSkWKSme7rpXQ4gFYqj66DFZuIWnA0ckMGxM56voXGEdkBOgdqvfxeoQM2lvcu1SIO1bgC2qnd0LcX1a6fgbHLK8zU0h9Cux/SMdA/sr3kudykddbPWDcA6ba11j66ldP2agrNIENoN0HO5gzZicelatzbO17tWADCZ9p/QyvB6RtdjU392lhFZv47WNX2/fen5wbEzm9P8S0amjpZ9pQ6cOi2bXn6DqSMARtEC2tc29DT2mUZr51gw0m6G7uce2B/opLBSzr7u/rspVANghnzOWcLTAtp6AltnG3U6fNNzhwjsmDDSDokWm+3d0BPoGLpSOqX06KE3nBaqABA3nQr/9qe761q3lmJ1+O0Hh2lHGjNCO0y6LWJDb13rQC7tvtb7whBT5gBioQONf16/tu6pcKWzi3qsMeJHaEdAi81+dldP3XeuUtwq0X/odaaaAERDq8I/d2tDgwudGVz53GFG1wliTTsCOtWte7q1OKNeW1fe6OyJdNa72SIGICzFdesP79/SUGDrVtfOgf0EdsIYaUesmVG33tX+cPhtpyMbADQkn5Nda7rka6tXNPQ5pGvXXzl0hM5mhiC046B3uD2rAh9fV47wBtAInbFrNKyFtWsjEdoxarTC3EV4AwhCj838Ts8tDX/WUBhrLkI7Ac3e/RLeAPw0G9a67/rvDx/hs8VghHZSmqjgdBHeAHT57ZFlnU2FtRQLzbYNv8XOFcMR2glrdspcCG8gm5osMHPpVPidL79BVbglCG1DNNqVqJSG99Ojp2S7NuznbhlIp7ZW2dW9vOmw5mbfToS2SZqsMnfputRv3jkl2468QyEJkBJ6mMf/XXuz08uhGfr58Mujx6kKtxShbaIQ1rtd2mHtuyMn2WMJWEp7Pfzd2pul5/qFTf8CrFvbj9A2mK53/7z3llDerNog4cdvHmMqDLBBPic7u5bLN9d8sql6F5fTHnnoLWbeUoDQtkCY4c3UOWCusKbAXRSZpQ+hbRGdJnt8/a2h3HlL8Q39i5GTjL6BJBW3bH1rzcqGTtzyo+/tbwy9zbJYChHaFmq2gUI5Rt9A/HQG7Xvdy+SemxY3VQVeirBOP0LbYmFOm7tm175PFihWAcLW1io7l98Q2lq1i7DODkI7BaIIb6VHi/5k5KRz1CiABhWnv7/evSz096gWmP31kXdYs84QQjtF3Om2sIpYXDp9/vy7p2X3ifcIcCAgrUF5uHtZKFs3y1ENnl2Edhq1tcpA76pQ18pc2kXp306OyTdHTnJ3D5TRoN62/IZI3nuzTVHoeJhphHaahbzXs5wG+OGxcUbgyLQog1rosYAyhHZGhNlVyc9VU+hjHzASQHoV16i/vLwzkqlvF90M4YfQzpq2Vtm99mb50s1LIxkVuLSIbV9hXHaceI91N1hPm578z85F8mDX0tD2UvuZPfRn5ATvG/gitLMqgoYOlbjr4AOFM0yjww75nDyw5Dpn2nvdko5IlpdKsVMDQRHaiG307XJH4T8onKGYDcbQ3RcPdS6SLy5bHPmNrDCqRoMIbVwlym0qfnQt/I+nxwlxxM6d8t7c2RHr9a61H6xVo1GENvwVK8+jXsMrR4gjKu5IekNnh3QvmBvLrJJLZ5eePlGg0yCaRmijtrZW2dW9XL7ctTTytT0/2qLxYGFcDoyfozIdwbS1ygMd86S/c5Hc1jEvsl0T1ehWradGT1GMiVAR2qiLTin+Y/cy+ctlSxIJcCnZH/7K+AX5zfh5phmzLp+TvoXznVH07R1z5ZaF8xK7NglqRI3QRsPcAL9jSUesU+h+9MPy6NmLcnzikjxZOCODOq3OiDx92lqlr73ViIB2EdSIE6GNcBRPL4p7DbwaXR8fOXfRmVp/e2JSXpi4xKjcFsXR85c65svK9hZnijvudehqZteoCx8Q1IgVoY3wlXSM+uziDmM+aF1umL8+fkHOT192RuZHpmcoekuAztaszeeckfOK9ha5qb3FqHB2XdWyl7oKJIjQRuS0avfbyzuNmEavRT+cC5OXZgNdi9/+Y/qyDE5MMaJqRHE6e2N7i9zS3mZ0MJfTAsh/PTHGLgYYhdBGvIqj8Hs7F8XSaSpsbqgrnXZX7tS7ysxaejGMlU5hd+Rzzn/X7VTKhlAud1XnPkbTMBShjWQV18K1wYWJU+nN0AKliZnLzt9wYXpGXhu/OPu3jU/POJXv5WJbcy+uGZfTaepSWuw1rxjInW0t1t1kVeNOeT9bOMPaNKxBaMMsba3ySOd11o7E41I64i9l4wg3LnoT9dLYuBwaP09Iwx5z26Rlzhz5b3NbZWHu44Q2DGdAkwzYp3TnAFsAYbRrPyEtLdfKXdd+Qm5tzcvauW3SnpsjK+e2Suucj3t+cm7JYbbJKdmjf0pOP3J7Rn+mY56sXjjX+OI2RE+LxrR4UEfRPx2/QOEYzDHn49Iyt11WzPm43DevVZa3XCudLZ+Qxdd+Qq5vydf9YxLasI5+IO8o+1DWCvXSPb2MyNOpdLseAQ1TtBTrQ77ZcWUA8bmO+dI25+Pyybmtof+EhDZSQQu4you49I30X9tb5O6OBU5B1Y1tLYzKLaKj53cnLn3U5Y5td0hK2bqyO4V968L4P08IbaSWjsD26J+SqXWxqKFHFpTviyeckYiydWV3CrvSunKS+JRC5miYD1bYXlUa6FKy75jp9sa409nuljd3qxsd6BCrsnXlBXPmyC3z2iKbwo4SoQ2U8AT68NVfd0Pd7fAlJcGu02VZmn7X6Wsp24NOBzkkxW9dWSUxhR0lQhuow0ehXvL/Gfb5/5c1LyntGiZlTUtccTcvKW3+4nLXkF2l3d6kwuwEEIviFHb5urKJU9hRIrSBKEzPXBVwYYadO9qvhFEurFScwi5fV250a1RaEdqAZdzRPmCb0ilsm9eVk0RoAwDCUbY1Kq3rykkitAEAwdTZchPhI7QBAFdU2BrFurI5CG0AyBC/rVGsK9uD0AaANDGo5SbCR2gDgE0qtNxkCjsbCG0AMEmFdWWmsCGENgAkoDiFnfaWmwgfoQ0AYaPlJiJCaANAvcqmsFlXRoj0NINzIjJU+s/exdc9L4Q2APij5SYiclxE/tPvT+/i6/6z1rcktAFkEy03EZ19FUbLQ81+R0IbQDpV2BrFujJC4E5hP1/8q5x/ulPYUSK0AdipwtYo1pURAncKe6h8xNy7+LpzST7BhDYAY9FyExE5XxbIs2vMQdaVk0RoA0hOhZabTGEjBPuKf8XzYa8rJ4nQBhCdCuvKTGEjBOVbo2JbV04SoQ2gKTqFTctNRKDS1qjE15WTRGgDqI6Wm4hG+bry7Pqy6evKSSK0gawrm8JmXRkhKl1Xdv9p/bpykghtIO1ouYno+LbczPoUdpQIbSAFaLmJiJwv3xJly9aotCK0ARtU2BrFujJCEFnLTYSP0AZMUGFrFOvKCEFiLTcRPkIbiAMtNxGd8q1RrCunGKENhMSv5aawNQrNs7blJsJHaANBVVhXZgobIUhly02Ej9AGXMUpbFpuIgK+W6NYV0a9CG1kCi03ERFabiIWhDbSpWwKm3VlhISWmzACoQ270HIT0fFrucnWKBiF0IZZaLmJ6Bwv3xLF1ijYhtBG7Py2RrGujBDQchOpR2gjfBW2RrGujBDQchOZRmijfrTcRHTKt0axrgyUILThVaHlJlPYCAEtN4EmENoZ5beuLGyNQvNouQlEiNBOq+IUNi03EQG/rVGsKwMxILRtRctNRIeWm4ChCG2DlU5hs66MENFyE7AUoZ0kWm4iGpVabjKFDViO0I4SLTcRneHSLVFsjQKygdBuRoWtUawrIwS03ATgQWjX4Lc1inVlhICWmwDqRmjTchPRKd0axboygKalP7QrtNxkChshoOUmgFjZH9oV1pWZwkYIaLkJwCh2hHZxCpuWmwhZpa1RrCsDMJIZoU3LTUSHlpsAUiOe0C6bwmZdGSGi5SaAzAgttGm5iYhUarnJFDaAzAke2rTcRHT2VRgtM4UNACU+Cu0KW6NYV0YIaLkJACGY87Oe7udFujfzZKIJtNwEgBjQEQ1BlG+NYl0ZABJAaMNFy00AMByhnR203AQAyxHa6VFpaxTrygCQEoS2PWi5CQAZR2ibhZabAICKCO14+bbcZAobABAEoR2u8+VbotgaBQAIC6FdP1puAgASQWh70XITAGCkLIZ2+dYo1pUBAFZIY2jTchMAkEq2hjYtNwEAmWNqaPtujWJdGQCQZUmFNi03AQCoU1ShTctNAABC1kxo+7XcZGsUAAARqRbax8u3RLE1CgCA5MwpGSmzNQoAAFOJyP8HN1lOx7cj7LgAAAAASUVORK5CYII=';



                                doc.pageMargins = [20, 150, 20, 30];

                                doc.defaultStyle.fontSize = 7;



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
                                                text: 'Sipariş Önizleme',
                                                fontSize: 18,
                                                absolutePosition: { x: 15, y: 30 }
                                            },
                                            {
                                                alignment: 'right',
                                                fontSize: 14,
                                                text: Kullanıcı_Adı + " " + dateTime
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
                    "footerCallback": function (row, data, start, end, display) {
                        var api = this.api(), data;

                        // Remove the formatting to get integer data for summation
                        var parseInt = function (i) {
                            return typeof i === 'string' ?
                                i.replace(/[\$,]/g, '') * 1 :
                                typeof i === 'number' ?
                                    i : 0;
                        };
                        var Adet_Toplam;
                        var Birim_Fiyat_Toplam;
                        var Normal_Fiyat_Toplam
                        // Total over all pages
                        total = api
                            .column(3)
                            .data()
                            .reduce(function (a, b) {
                                return parseInt(a) + parseInt(b);
                            });

                        // Total over this page
                        pageTotal = api
                            .column(3, { page: 'current' })
                            .data()
                            .reduce(function (a, b) {
                                return parseInt(a) + parseInt(b);
                            });
                        Adet_Toplam = parseInt(pageTotal)

                        // Update footer
                        $(api.column(3).footer()).html(

                            "" + pageTotal.toLocaleString("tr") + " Adet"
                        );

                        // Total over all pages

                        total = api
                            .column(6)
                            .data()
                            .reduce(function (a, b) {
                                return parseInt(a) + parseInt(b);
                            });

                        // Total over this page
                        pageTotal = api
                            .column(6, { page: 'current' })
                            .data()
                            .reduce(function (a, b) {
                                return parseInt(a) + parseInt(b);
                            });
                        Birim_Fiyat_Toplam = parseFloat(pageTotal)
                        // Update footer
                        $(api.column(6).footer()).html(
                            "" + pageTotal.toLocaleString("tr") + "₺"
                        );

                        // Total over all pages

                        total = api
                            .column(7)
                            .data()
                            .reduce(function (a, b) {
                                return parseInt(a) + parseInt(b);
                            });

                        // Total over this page
                        pageTotal = api
                            .column(7, { page: 'current' })
                            .data()
                            .reduce(function (a, b) {
                                return parseInt(a) + parseInt(b);
                            });
                        Normal_Fiyat_Toplam = parseFloat(pageTotal)
                        // Update footer
                        $(api.column(7).footer()).html(
                            "" + pageTotal.toLocaleString("tr") + "₺"
                        );

                    },
                    "scrollX": true,


                });


                $('a[id=Sipariş_Detay_Düzenle]').click(function () {
                    $('#Sipariş_Detay_Düzenle_Modal').modal('show');
                    $('#Ziyaret_Modal').modal('toggle');
                    $('button[id=Sipariş_Detay_Düzenle_Modal_Kaydet]').attr('Sipariş_Detay_Id', $(this).attr("Sipariş_Detay_Id"))
                    $('button[id=Sipariş_Detay_Düzenle_Modal_Kaydet]').attr('Sipariş_Genel_Id', $(this).attr("Sipariş_Genel_Id"))

                    //$.ajax({
                    //    url: 'Sipariş-Onay.aspx/Sipariş_Detay',
                    //    type: 'POST',
                    //    data: "{'Sipariş_Detay_Id': '" + $(this).attr("Sipariş_Detay_Id") + "'" +
                    //        "'Sipariş_Genel_Id':'" + $(this).attr("Sipariş_Genel_Id")+"'" +
                    //        "'Adet':''" +
                    //        "'Mf_adet':''" +
                    //        "}",
                    //    async: true,
                    //    dataType: "json",
                    //    contentType: "application/json; charset=utf-8",
                    //    success: function (data) {
                    //        var temp = JSON.parse(data.d)


                    //        $('#Ziyaret_Modal').modal('show');


                    //    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    //    error: function () {

                    //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    //    }
                    //})

                })



            }
            $('button[id=Sipariş_Detay_Düzenle_Modal_Kaydet]').click(function () {

                var Sipariş_Genel_Id__ = $(this).attr("Sipariş_Genel_Id")

                $.ajax({
                    url: 'Sipariş-Onay.aspx/Sipariş_Detay_Düzenle',
                    type: 'POST',
                    data: "{'Sipariş_Detay_Id': '" + $(this).attr("Sipariş_Detay_Id") + "'," +
                        "'Sipariş_Genel_Id':'" + $(this).attr("Sipariş_Genel_Id") + "'," +
                        "'Adet':'" + $('input[id=Adet]').val() + "'," +
                        "'Mf_adet':'" + $('input[id=Mf_Adet]').val() + "'" +
                        "}",
                    async: true,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var temp = JSON.parse(data.d)

                        var Sipariş_Genel_Id_ = Sipariş_Genel_Id__
                        $.ajax({
                            url: 'Sipariş-Onay.aspx/Sipariş_Detay',
                            type: 'POST',
                            data: "{'Sipariş_ıd': '" + Sipariş_Genel_Id_ + "'}",
                            async: true,
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                var temp = JSON.parse(data.d)

                                Molad_Liste = [];
                                for (var i = 0; i < temp.length; i++) {


                                    var MyClass = {
                                        Urun_Adı: null,
                                        Adet: null,
                                        Mf_Adet: null,
                                        Toplam: null,
                                        Birim_Fiyat: null,
                                        Satış_Fiyat: null,
                                        Birim_Fiyat_Toplam: null,
                                        Normal_Toplam: null,
                                        Sipariş_Detay_Id: null,
                                        Sipariş_Genel_Id: null
                                    }

                                    MyClass.Urun_Adı = temp[i].Urun_Adı
                                    MyClass.Adet = temp[i].Adet
                                    MyClass.Mf_Adet = temp[i].Mf_Adet
                                    MyClass.Toplam = temp[i].Toplam
                                    MyClass.Birim_Fiyat = temp[i].Birim_Fiyat
                                    MyClass.Satış_Fiyat = temp[i].Satış_Fiyat
                                    MyClass.Birim_Fiyat_Toplam = temp[i].Birim_Fiyat_Toplam
                                    MyClass.Normal_Toplam = temp[i].Normal_Toplam
                                    MyClass.Sipariş_Detay_Id = temp[i].Sipariş_Detay_Id
                                    MyClass.Sipariş_Genel_Id = Sipariş_Genel_Id_


                                    Molad_Liste.push(MyClass);

                                }



                                Tabloyu_Doldur_Detay(Molad_Liste)

                                $('#Ziyaret_Modal').modal('show');


                            },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                            error: function () {

                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        })

                        //$.ajax({
                        //    url: 'Sipariş-Onay.aspx/Tablo_Verisi',
                        //    type: 'POST',
                        //    data: "{'Tar_1': '" + TextBox2.val() + "','Tar_2':'" + TextBox3.val() + "'}",
                        //    async: false,
                        //    dataType: "json",
                        //    contentType: "application/json; charset=utf-8",
                        //    success: function (data) {
                        //        var temp = JSON.parse(data.d)
                        //        Liste = [];

                        //        for (var i = 0; i < temp.length; i++) {

                        //            var MyClass = {
                        //                Eczane_Adı: null,
                        //                Şehir: null,
                        //                Brick: null,
                        //                Tar: null,
                        //                Onay_Durum: null,
                        //                Detay: null,
                        //                Kullanıcı_Ad_Soyad: null,
                        //                Sil: null,
                        //                İletim_Durum: null,
                        //                Onaylanmadıya_Düştümü: null,
                        //                Sipariş_Tekrar_Gönderlidimi: null,
                        //                Depo: null,
                        //                Eczacı_Adı: null,
                        //                Düzenlendimi: null,

                        //            }

                        //            MyClass.Eczane_Adı = temp[i].Eczane_Adı
                        //            MyClass.Şehir = temp[i].CityName
                        //            MyClass.Brick = temp[i].TownName
                        //            MyClass.Tar = temp[i].Tar
                        //            MyClass.Onay_Durum = temp[i].Onay_Durum
                        //            MyClass.Detay = temp[i].Siparis_Genel_Id
                        //            MyClass.Sil = temp[i].Siparis_Genel_Id
                        //            MyClass.Kullanıcı_Ad_Soyad = temp[i].Kullanıcı_Ad_Soyad
                        //            MyClass.İletim_Durum = temp[i].İletim_Durum
                        //            MyClass.Onaylanmadıya_Düştümü = temp[i].Onaylanmadıya_Düştümü
                        //            MyClass.Sipariş_Tekrar_Gönderlidimi = temp[i].Sipariş_Tekrar_Gönderlidimi
                        //            MyClass.Depo = temp[i].Depo
                        //            MyClass.Eczacı_Adı = temp[i].Eczacı_Adı
                        //            MyClass.Düzenlendimi = temp[i].Düzenlendimi

                        //            Liste.push(MyClass);

                        //        }

                        //        Tabloyu_Doldur(Liste)




                        //    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        //    error: function () {

                        //        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        //    }
                        //});



                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                })
            })



            $('#Ziyaret_Modal').on('show.bs.modal', function (e) {

                setTimeout(function () { $('#example_Detay').DataTable().rows().invalidate().draw() }, 450);

            })
            var cal_set = $('input[id=cal_set]')
            var cal_set_Onaylanan = $('input[id=cal_set_Onaylanan]')
            var cal_set_Reddedilen = $('input[id=cal_set_Reddedilen]')
            cal_set_Reddedilen.click(function () {
                Liste = [];
                Tablo_Listesini_Doldur_Red();
                var Sipariş_Detay = $('a[id=Sipariş_Detay]')
                Sipariş_Detay.click(function () {

                    var Ziyaret_Modal_Red = $('button[id=Ziyaret_Modal_Red]')
                    Ziyaret_Modal_Red.attr('value', $(this).attr("value"))
                    var Ziyaret_Modal_Onay = $('button[id=Ziyaret_Modal_Onay]')
                    Ziyaret_Modal_Onay.attr('value', $(this).attr("value"))


                    $.ajax({
                        url: 'Sipariş-Onay.aspx/Sipariş_Detay',
                        type: 'POST',
                        data: "{'Sipariş_ıd': '" + $(this).attr("value") + "'}",
                        async: true,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var temp = JSON.parse(data.d)

                            Molad_Liste = [];
                            for (var i = 0; i < temp.length; i++) {


                                var MyClass = {
                                    Urun_Adı: null,
                                    Adet: null,
                                    Mf_Adet: null,
                                    Toplam: null,
                                    Birim_Fiyat: null,
                                    Satış_Fiyat: null,
                                    Birim_Fiyat_Toplam: null,
                                    Normal_Toplam: null,
                                }

                                MyClass.Urun_Adı = temp[i].Urun_Adı
                                MyClass.Adet = temp[i].Adet
                                MyClass.Mf_Adet = temp[i].Mf_Adet
                                MyClass.Toplam = temp[i].Toplam
                                MyClass.Birim_Fiyat = temp[i].Birim_Fiyat
                                MyClass.Satış_Fiyat = temp[i].Satış_Fiyat
                                MyClass.Birim_Fiyat_Toplam = temp[i].Birim_Fiyat_Toplam
                                MyClass.Normal_Toplam = temp[i].Normal_Toplam

                                Molad_Liste.push(MyClass);

                            }


                            Tabloyu_Doldur_Detay(Molad_Liste)
                            $('#Ziyaret_Modal').modal('show');


                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });



                })
            })
            cal_set.click(function () {


                buildTable_Hasta_Listesi($Hasta_Listesi, 1, 1)

            })
            cal_set_Onaylanan.click(function () {
                Molad_Liste = [];
                Tablo_Listesini_Doldur_Onaylanan();
                var Sipariş_Detay = $('a[id=Sipariş_Detay]')
                Sipariş_Detay.click(function () {


                    $.ajax({
                        url: 'Sipariş-Onay.aspx/Sipariş_Detay',
                        type: 'POST',
                        data: "{'Sipariş_ıd': '" + $(this).attr("value") + "'}",
                        async: true,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var temp = JSON.parse(data.d)

                            Molad_Liste = [];
                            for (var i = 0; i < temp.length; i++) {


                                var MyClass = {
                                    Urun_Adı: null,
                                    Adet: null,
                                    Mf_Adet: null,
                                    Toplam: null,
                                    Birim_Fiyat: null,
                                    Satış_Fiyat: null,
                                    Birim_Fiyat_Toplam: null,
                                    Normal_Toplam: null,
                                }

                                MyClass.Urun_Adı = temp[i].Urun_Adı
                                MyClass.Adet = temp[i].Adet
                                MyClass.Mf_Adet = temp[i].Mf_Adet
                                MyClass.Toplam = temp[i].Toplam
                                MyClass.Birim_Fiyat = temp[i].Birim_Fiyat
                                MyClass.Satış_Fiyat = temp[i].Satış_Fiyat
                                MyClass.Birim_Fiyat_Toplam = temp[i].Birim_Fiyat_Toplam
                                MyClass.Normal_Toplam = temp[i].Normal_Toplam

                                Molad_Liste.push(MyClass);

                            }


                            Tabloyu_Doldur_Detay(Molad_Liste)

                            $('#Ziyaret_Modal').modal('show');

                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });



                })
            })

            var Ziyaret_Modal_Red = $('button[id=Ziyaret_Modal_Red]')
            var İşlem_Mesajı = $('div[id=İşlem_Mesajı]')
            Ziyaret_Modal_Red.click(function () {

                İşlem_Mesajı.append('Sipariş Reddedildi Olarak Kaydedilecek!')
                $('div[id=myModal]').modal('show')
                var Siparişi_İptal_Talebi_Olustur = $('button[id=Siparişi_İptal_Talebi_Olustur]')
                Siparişi_İptal_Talebi_Olustur.attr('islem', '0')
                Siparişi_İptal_Talebi_Olustur.attr('class', 'btn btn-danger')
                Siparişi_İptal_Talebi_Olustur.attr('value', $(this).attr('value'))
                Siparişi_İptal_Talebi_Olustur.empty();
                Siparişi_İptal_Talebi_Olustur.append('Reddet')

            });
            var Ziyaret_Modal_Onay = $('button[id=Ziyaret_Modal_Onay]')
            Ziyaret_Modal_Onay.click(function () {


                $('textarea[id=Sipariş_Onay_Notu]').val('')
                $.ajax({
                    url: 'Sipariş-Onay.aspx/Sipariş_Notu_Getir',
                    type: 'POST',
                    data: "{'Sipariş_Id': '" + $(this).attr("value") + "'}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var temp = JSON.parse(data.d)
                        console.log(data.d)
                        $('textarea[id=Sipariş_Onay_Notu]').val(temp[0].Sipariş_Notu)

                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


                İşlem_Mesajı.append('Sipariş İşleme Alındı Olarak Kaydedilecek!')
                $('div[id=myModal]').modal('show')
                var Siparişi_İptal_Talebi_Olustur = $('button[id=Siparişi_İptal_Talebi_Olustur]')
                Siparişi_İptal_Talebi_Olustur.attr('islem', '1')
                Siparişi_İptal_Talebi_Olustur.attr('class', 'btn btn-primary')
                Siparişi_İptal_Talebi_Olustur.attr('value', $(this).attr('value'))
                Siparişi_İptal_Talebi_Olustur.empty();
                Siparişi_İptal_Talebi_Olustur.append('Sipariş Durumunu Güncelle')
            });

            var Siparişi_İptal_Talebi_Olustur = $('button[id=Siparişi_İptal_Talebi_Olustur]')
            Siparişi_İptal_Talebi_Olustur.click(function () {
                if ($(this).attr('islem') == "1") {
                    var İletim_Durmu = $('select[id=İletim_Durmu]')
                    $.ajax({
                        url: 'Sipariş-Onay.aspx/Onay_Durumu_Güncelle',
                        type: 'POST',
                        data: "{'Sipariş_Id': '" + $(this).attr("value") + "','islem':'1','İletim_Durmu':'" + İletim_Durmu.find('option:selected').attr('value') + "','Sipariş_Nou':'" + $('textarea[id=Sipariş_Onay_Notu]').val() + "'}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            buildTable_Hasta_Listesi($Hasta_Listesi, 1, 1)
                            // $('#İşlem_Başarılı').modal('show');
                            Swal.fire({
                                title: 'Başarılı!',
                                text: 'İşlem Başarı İle Kaydedildi',
                                icon: 'success',
                                confirmButtonText: 'Kapat'
                            })



                            //window.location.assign("/Sipariş-Onay.aspx")

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }

            });


        })

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Sipariş_Detay_Düzenle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Sipariş_Detay_Düzenle_Modal_Başlık" class="modal-title">Sipariş Detayı Düzenle</h4>
                </div>
                <div id="Sipariş_Detay_Düzenle_Modal_Başlık_Body" class="modal-body">
                    <div class="row">
                        <div class="col-xs-6">
                            <label>Adet:</label>
                        </div>
                        <div class="col-xs-6">
                            <label>Mf Adet:</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <input type="text" class="form-control" id="Adet" />
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <input type="text" class="form-control" id="Mf_Adet" />
                            </div>
                        </div>
                    </div>


                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    <button type="button" id="Sipariş_Detay_Düzenle_Modal_Kaydet" class="btn btn-info" data-dismiss="modal">Kaydet</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="myModalLabel">Siparişi Durumu Güncelle</h4>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İletim Durumu Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="İletim_Durumu_Select" id="İletim_Durmu" class="form-control">
                                        <option value="6">Güncelleme Bekleniyor</option>
                                        <option value="1">Depoya İletildi</option>
                                        <option value="2">Depo Onayladı</option>
                                        <option value="3">Sevkiyatta</option>
                                        <option value="4">Eczaneye Ulaştı</option>
                                        <option value="5">Eczane Onaylamadı</option>
                                        <option value="7">Sipariş İptal Edildi</option>

                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12" style="padding-top: 40px;">
                                <textarea class="form-control" rows="4" id="Sipariş_Onay_Notu" placeholder="Sipariş Notu"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Siparişi_İptal_Talebi_Olustur" class="btn btn-primary"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="Ziyaret_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="Modal_başlık" class="modal-title">Sipariş Detayı</h4>
                </div>
                <div id="Modal_Body" class="modal-body">
                    <div class="row">
                        <div id="Tablo_Div_Siparişlerim_Detay" class="col-xs-12">
                        </div>
                    </div>


                </div>

                <div class="modal-footer">
                    <button type="button" id="Ziyaret_Modal_kapat" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    <button type="button" id="Ziyaret_Modal_Onay" class="btn btn-info" data-dismiss="modal">Siparişi İşleme Al</button>
                </div>
            </div>

        </div>
    </div>


    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tab_1" data-toggle="tab" aria-expanded="false">Siparişler
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab_1">
                        <div class="box">
                            <div class="box-body">
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
                                 <div class="row">
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                 <label>İletim Durumu:</label>
                                                <select name="İletim_Durumu_Select___" id="İletim_Durmu_Filtre" class="form-control">
                                                    <option value="0">Hepsi</option>
                                                    <option value="6">Güncelleme Bekleniyor</option>
                                                    <option value="1">Depoya İletildi</option>
                                                    <option value="2">Depo Onayladı</option>
                                                    <option value="3">Sevkiyatta</option>
                                                    <option value="4">Eczaneye Ulaştı</option>
                                                    <option value="5">Eczane Onaylamadı</option>
                                                    <option value="7">Sipariş İptal Edildi</option>
                                                </select>

                                            </div>
                                        </div>
                                    </div>
                                <div class="row">
                                    <div id="Tablo_Div_Siparişlerim_Siparişlerim" class="col-xs-12">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <table data-search="true" id="Tablo_Div_Siparişlerim_Siparişlerim_Pagenation">
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="row">
                                <div class="form-group">
                                    <div class="col-xs-12">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
</asp:Content>
