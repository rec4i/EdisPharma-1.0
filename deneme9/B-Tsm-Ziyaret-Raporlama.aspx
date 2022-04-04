<%@ Page Title="" Language="C#" MasterPageFile="~/b.Master" AutoEventWireup="true" CodeBehind="B-Tsm-Ziyaret-Raporlama.aspx.cs" Inherits="deneme9.B_Ziyaret_Raporlama" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

            var d = new Date(x.getFullYear(), x.getMonth() + 1, 0);
            TextBox3.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), x.getMonth(), 1);
            TextBox2.attr('value', formatDate(d));
            Bölge
            var Tsm_Ad = $('select[id=Tsm_Ad]')


            var Bölge = $('select[id=Bölge]')
            $.ajax({
                url: 'B-Tsm-Ziyaret-Raporlama.aspx/Bolge_Listesi',
                type: 'POST',
                data: "{'Şehir_Id': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsdata = JSON.parse(data.d)

                    Bölge.empty();
                    Bölge.append('<option value="0">Lütfen Bölge Seçiniz</option>')
                    for (var i = 0; i < parsdata.length; i++) {
                        Bölge.append('<option value="' + parsdata[i].Bolge_Id + '">' + parsdata[i].Bolge_Ad + '</option>')
                    }


                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });
            Bölge.change(function () {
                if ($(this).find('option:selected').attr('value') != "0") {
                 
                    $.ajax({
                        url: 'B-Tsm-Ziyaret-Raporlama.aspx/Kullanıcı_Listesi',
                        type: 'POST',
                        data: "{'Bolge_Id': '" + $(this).find('option:selected').attr('value')+"'}",
                        async: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                         
                            var parsdata = JSON.parse(data.d)

                            Tsm_Ad.empty();
                            Tsm_Ad.append('<option value="0">Lütfen TSM Seçiniz</option>')
                            for (var i = 0; i < parsdata.length; i++) {
                                Tsm_Ad.append('<option value="' + parsdata[i].Kullanıcı_ID + '">' + parsdata[i].Ad + ' ' + parsdata[i].Soyad + '</option>')
                            }


                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        }
                    });
                }
              
                
            });
            

          
            if (window.location.href.split('&').length > 1) {
                var Gün_Div = $('div[id=Gün_Div]')
                Gün_Div.attr('style', "visibility:visible")
                Tsm_Ad.val(window.location.href.split('&')[2].split('=')[1])
                TextBox2.val(window.location.href.split('&')[0].split('=')[1])
                TextBox3.val(window.location.href.split('&')[1].split('=')[1])
            }

            else {
                var Gün_Div = $('div[id=Gün_Div]')
                Gün_Div.attr('style', "visibility:hidden")
            }

            Tsm_Ad.change(function () {//Dktr_Brans.parent().children().find($("select option:first-child"))
                if (Tsm_Ad.parent().children().find($("select option:first-child")).val() == "0") {
                    Tsm_Ad.parent().children().find($("select option:first-child")).remove();
                }

            })
            var cal_set = $('input[id=cal_set]')
            cal_set.on('click', function () {
                if (Tsm_Ad.find('option:selected').val() != 0) {
                    window.location.href = "B-Tsm-Ziyaret-Raporlama.aspx?x=" + TextBox2.val() + "&y=" + TextBox3.val() + "&z=" + Tsm_Ad.find('option:selected').val()
                }
                else {
                    alert("Lütfen TSM Seçiniz")
                }
            });
            var Bas_Gun = TextBox2.val();
            var Son_Gun = TextBox3.val();
            var Kullanıcı = window.location.href.split('&')[2].split('=')[1];
            var Kullanıcı_Ad = Tsm_Ad.find('option:selected').html()

            var parsdata;
            $.ajax({
                url: 'B-Tsm-Plan-Raporlama.aspx/Ziyaret_Edilecekler',
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı +"'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {



                    for (var i = 0; i < data.d.split('!').length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                        var Header_Gun_span = $('span[id=Header_Sayac_span_' + parseInt(data.d.split('!')[i].split('/')[0]) + ']')

                        Header_Gun_span.empty();
                        Header_Gun_span.append("Doktor:" + data.d.split('!')[i].split('/')[2] + "</br>" + "Eczane:" + data.d.split('!')[i].split('/')[1])
                    }

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            $.ajax({
                url: 'Tsm-Ziyaret-Raporu.aspx/Tabloları_Doldur',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    console.log(temp)

                    for (var i = 0; i < temp.length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                        var label_str = ""
                        if (temp[i].Ziyaret_Durumu == "0") {

                            label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                        }
                        else if (temp[i].Ziyaret_Durumu == "1") {
                            label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                        }
                        else if (temp[i].Ziyaret_Durumu == "2") {
                            label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
                        }

                        var Doktor_Div = $('tbody[id = Gun_Doktor_' + parseInt(temp[i].Gun) + ']');

                        Doktor_Div.append('<tr><td>' + temp[i].Doktor_Ad + '</td><td>' + temp[i].Brans + '</td><td>' + temp[i].Unite + '</td><td>' + temp[i].Brick + '</td>' + label_str + '<td>' + temp[i].Urun_1 + '</td><td>' + temp[i].Urun_2 + '</td><td>' + temp[i].Urun_3 + '</td><td>' + temp[i].Ziyaret_Notu + '</td></tr>')

                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            $.ajax({
                url: 'Tsm-Ziyaret-Raporu.aspx/Tabloları_Doldur_Eczane',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)
                


                    for (var i = 0; i < temp.length; i++) {// '<td><span class="label label-waring">Ziyret bekleniyor</span></td>'

                        var label_str = ""
                        if (temp[i].Ziyaret_Durumu == "0") {

                            label_str += '<td><span class="label label-waring">Ziyret Bekleniyor</span></td>'
                        }
                        else if (temp[i].Ziyaret_Durumu == "1") {
                            label_str += '<td><span class="label label-success">Ziyret Edildi</span></td>'
                        }
                        else if (temp[i].Ziyaret_Durumu == "2") {
                            label_str += '<td><span class="label label-danger">Ziyret Edilmedi</span></td>'
                        }

                        var Doktor_Div = $('tbody[id = Gun_Eczane_' + parseInt(temp[i].Gun) + ']');

                        Doktor_Div.append('<tr><td>' + temp[i].Eczane_Adı + '</td><td>' + temp[i].Şehir + '</td><td>' + temp[i].Brick + '</td>' + label_str + '<td>' + temp[i].Urun_1 + '</td><td>' + temp[i].Urun_2 + '</td><td>' + temp[i].Urun_3 + '</td><td>' + temp[i].Ziyaret_Notu + '</td></tr>')

                    }





                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            function Veriyi_Getir() {
                var Veri;
                $.ajax({
                    url: 'Tsm-Ziyaret-Raporu.aspx/Gun_Doldur',
                    type: 'POST',
                    data: "{'TSM':'" + Kullanıcı + "','Bas_Tar':'" + TextBox2.val() + "','Bit_Tar':'" + TextBox3.val() + "'}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {


                        parsdata = JSON.parse(data.d)
                        Veri = parsdata;

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });
                var yeni;
               Veri.sort(function (a, b) {
                   if (parseInt(a[0].Ziy_Tar.split('-')[0]) < parseInt(b[0].Ziy_Tar.split('-')[0])) return -1;
                   if (parseInt(a[0].Ziy_Tar.split('-')[0]) > parseInt(b[0].Ziy_Tar.split('-')[0])) return 1;
                    return 0;
               });
               
                return Veri;
            }

            var Seçili_Günleri_Yazdı = $('input[id=Seçili_Günleri_Yazdı]')
            var Hepsini_Yazdır = $('input[id=Hepsini_Yazdır]')
            Hepsini_Yazdır.click(function () {
                var veri = Veriyi_Getir();
                var logo = 'data:image/png;base64,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';
                var dd = {
                    header: function (page, currentPage, pageCount, pageSize) {
                        if (page == 1)
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
                                        text: 'Tsm Ziyaret Raporu',
                                        fontSize: 18,
                                        absolutePosition: { x: 15, y: 30 }
                                    },
                                    {
                                        fontSize: 14,
                                        absolutePosition: { x: 450, y: 15 },
                                        text: Kullanıcı_Ad
                                    },
                                    {
                                        fontSize: 14,
                                        absolutePosition: { x: 430, y: 30 },
                                        text: Bas_Gun + "/" + Son_Gun
                                    },

                                ],
                                margin: 20

                            }
                        else
                            return {}
                    },



                    content: [


                    ],
                    styles: {
                        header: {
                            fontSize: 14,
                            bold: true
                        },
                        cell: {
                            color: 'red',
                            fillColor: 'yellow'
                        }
                    },
                    pageMargins: [30, 100, 30, 40]
                }


                for (var i = 0; i < veri.length; i++) {
                    var Doktor_Tablo = [
                        [
                            {
                                text: 'Doktor Adı',
                                fillColor: '#555555',
                                color: '#00FFFF',
                            },
                            {
                                text: 'Ünite',
                                color: '#555555',
                                fillColor: '#dedede'
                            },
                            {
                                text: 'Branş',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Brick',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Ziyaret_Durumu',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Çalışılan Urun 1',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Çalışılan Urun 2',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Çalışılan Urun 3',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Ziyaret Notu',
                                fillColor: '#555555'
                            }
                        ],

                    ];
                    var Eczane_Tablo = [
                        [
                            {
                                text: 'Eczane Adı',
                                fillColor: '#555555',
                                color: '#00FFFF',
                            },
                            {
                                text: 'Brick',
                                color: '#555555',
                                fillColor: '#dedede'
                            },
                            {
                                text: 'Şehir',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Ziyaret_Durumu',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Çalışılan Urun 1',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Çalışılan Urun 2',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Çalışılan Urun 3',
                                fillColor: '#555555'
                            },
                            {
                                text: 'Ziyaret Notu',
                                fillColor: '#555555'
                            }

                        ],

                    ];
                    var Doktor_Sayısı = 0;
                    var Eczane_Sayısı = 0;
                    for (var k = 0; k < veri[i].length; k++) {
                        if (veri[i][k].Cins == "0") {
                            Doktor_Sayısı += 1;
                        }
                        if (veri[i][k].Cins == "1") {
                            Eczane_Sayısı += 1;
                        }
                    }
                    for (var j = 0; j < veri[i].length; j++) {
                        var Ziyaret_Str = "";
                        if (veri[i][j].Ziyaret_Durumu == "0") {
                            console.log("asdsa")
                            Ziyaret_Str = "Ziyaret Bekleniyor"
                        }
                        if (veri[i][j].Ziyaret_Durumu == "1") {
                            console.log("asdsa")
                            Ziyaret_Str = "Ziyaret Edildi"
                        }
                        if (veri[i][j].Ziyaret_Durumu == "2") {
                            console.log("asdsa")
                            Ziyaret_Str = "Ziyaret Edilmedi"
                        }
                        if (veri[i][j].Cins == "0") {

                            Doktor_Tablo.push(
                                [
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Doktor_Ad
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Brans_Txt
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Unite_Txt
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].TownName
                                    },
                                    {
                                        fontSize: 8,
                                        text: Ziyaret_Str
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Urun_1
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Urun_2
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Urun_3
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Ziyaret_Notu
                                    },

                                ]
                            );
                        }
                        if (veri[i][j].Cins == "1") {
                            Eczane_Tablo.push(
                                [
                                    {
                                        text: veri[i][j].Eczane_Adı
                                    },
                                    {
                                        text: veri[i][j].TownName
                                    },
                                    {
                                        text: veri[i][j].CityName
                                    },
                                    {
                                        fontSize: 8,
                                        text: Ziyaret_Str
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Urun_1
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Urun_2
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Urun_3
                                    },
                                    {
                                        fontSize: 8,
                                        text: veri[i][j].Ziyaret_Notu
                                    },
                                ]
                            );
                        }

                    }
                    if (Doktor_Sayısı == 0) {
                        Doktor_Tablo.push(
                            [
                                { text: 'Tabloda Hiç Veri Bulunamadı', colSpan: 9, alignment: 'center' }
                            ]
                        );
                    }
                    if (Eczane_Sayısı == 0) {
                        Eczane_Tablo.push(
                            [
                                { text: 'Tabloda Hiç Veri Bulunamadı', colSpan: 8, alignment: 'center' }
                            ]
                        );
                    }

                    dd.content.push([
                        {
                            text: veri[i][0].Ziy_Tar.split('-')[0] + '/' + veri[i][0].Ziy_Tar_Str.replace('.', '/').replace('.', '/').split('/')[1] + '/' + veri[i][0].Ziy_Tar_Str.replace('.', '/').replace('.', '/').split('/')[2],
                            margin: [0, 40, 0, 0],

                        },
                        {
                            margin: [0, 30, 0, 0],
                            style: 'tableExample',

                            table: {
                                widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto','auto'],

                                headerRows: 1,


                                body: Doktor_Tablo
                            }

                        },
                        {
                            width: ['*'],
                            margin: [0, 15, 0, 0],
                            style: 'tableExample',

                            table: {
                                widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto','auto'],
                                headerRows: 1,


                                body: Eczane_Tablo
                            }

                        }
                    ]);



                }



                pdfMake.createPdf(dd).download();
            })





        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box">
        <div class="box-body">
            <div class="row">
                 <div class="col-xs-6">
                    <div class="form-group">
                        <%--// has-error--%>
                        <label>Bölge</label>
                        <select id="Bölge" class="form-control">
                        </select>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <%--// has-error--%>
                        <label>TSM Adı</label>
                        <select id="Tsm_Ad" class="form-control">
                        </select>
                    </div>
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
    <div class="box" id="Gün_Div" style="visibility: hidden">
        <div class="box-body" id="Günler">
            <div class="row">

                <div class="col-xs-12">
                    <div class="form-group">
                        <input id="Hepsini_Yazdır" type="button" class="btn btn-block btn-info" value="Yazdır" />
                    </div>
                </div>
            </div>
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>



                    <div class="row">
                        <div class="col-lg-12">
                            <div class="box box-default box-solid collapsed-box">
                                <div class="box-header with-border  bg-blue-gradient">

                                    <span id="gun" class="col-xs-1" style="font-size: 50px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:%d}") %></span>
                                    <span id="ay_yıl" class="col-xs-1" style="font-size: 22px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:% MMMM}") %></br><%#Eval("Ziy_Tar","{0:% yyyy}") %></span>
                                    <span class="col-xs-3" style="font-size: 12px;"></span>
                                    <span id="Header_Sayac_span_<%#Eval("Ziy_Tar","{0:%d}") %>" class="col-xs-3" style="font-size: 20px;"></span>
                                    <span id="Gun_txt_1" class="col-xs-1" style="font-size: 20px"><%#Eval("Ziy_Tar","{0:% dddddd}") %></span>

                                    <div class="box-tools ">

                                        <button type="button" class=" btn-primary no-border bg-blue-gradient" data-widget="collapse" style="font-size: 50px">

                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <!-- /.box-tools -->
                                </div>
                                <!-- /.box-header -->

                                <div class="box-body" style="display: none;">
                                    <label>Ziyaret Edilecek Doktor Listesi</label>
                                    <div class="box">
                                        <table class="table table-hover" id="doktor_<%#Eval("Ziy_Tar","{0:%d}") %>">
                                            <thead>
                                                <tr>
                                                    <th>Doktor Adı</th>
                                                    <th>Ünite</th>
                                                    <th>Branş</th>
                                                    <th>Brick</th>
                                                    <th>Ziyaret Durumu</th>
                                                    <th>Çalışılan Ürün 1</th>
                                                    <th>Çalışılan Ürün 2</th>
                                                    <th>Çalışılan Ürün 3</th>
                                                    <th>Ziyaret Notu</th>


                                                </tr>
                                            </thead>
                                            <tbody id="Gun_Doktor_<%#Eval("Ziy_Tar","{0:%d}") %>">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>



                                <div class="box-body" style="display: none;">
                                    <label>Ziyaret Edilecek Eczane Listesi</label>
                                    <div class="box">
                                        <div class="form-group">
                                            <table class="table table-hover" id="eczane_<%#Eval("Ziy_Tar","{0:%d}") %>">
                                                <thead>
                                                    <tr>
                                                        <th>Eczane Adı</th>
                                                        <th>İl</th>
                                                        <th>Brick</th>
                                                        <th>Ziyaret Durumu</th>
                                                        <th>Çalışılan Ürün 1</th>
                                                        <th>Çalışılan Ürün 2</th>
                                                        <th>Çalışılan Ürün 3</th>
                                                        <th>Ziyaret Notu</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="Gun_Eczane_<%#Eval("Ziy_Tar","{0:%d}") %>">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

