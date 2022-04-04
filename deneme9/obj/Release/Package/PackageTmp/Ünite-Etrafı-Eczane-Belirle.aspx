<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Ünite-Etrafı-Eczane-Belirle.aspx.cs" Inherits="deneme9.Ünite_Etrafı_Eczane_Belirle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">


        $(document).ready(function () {
            var Doktor_Liste_Il = $('select[id=Doktor_Liste_Il]');
            Doktor_Liste_Il.append("<option value='0'>Lütfen İl Seçiniz</option>");
            var Doktor_Liste_Brick = $('select[id=Doktor_Liste_Brick]');
            var Doktor_Liste_Untie = $('select[id=Doktor_Liste_Untie]');
            var Eczane_Yeni_Liste_Olustur_Modal_btn = $('button[id=Eczane_Yeni_Liste_Olustur_Modal_btn]'); //doktorları listelerken tersten listele 
            var Eczane_Liste_Olustur_Liste = $('select[id=Eczane_Liste_Olustur_Liste]');
            var Eczane_Yeni_Liste_Input = $('input[id=Eczane_Yeni_Liste_Input]');
            var Eczane_Listesi_Tablosu = $('table[id=Eczane_Listesi_Tablosu]');
            var Eczane_Liste_Ekle_btn = $('a[id=Eczane_Liste_Ekle_btn]') //doktorları listelerken tersten listele 
            var Eczane_Liste_Il = $('select[id=Eczane_Liste_Il]');
            Eczane_Liste_Il.append("<option value='0' >Lütfen İl Seçiniz</option>");
            var Eczane_Liste_Brick = $('select[id=Eczane_Liste_Brick]');
            var Eczane_Liste_Eczane = $('select[id=Eczane_Liste_Eczane]');
            var Eczane_Liste_Frekans = $('select[id=Eczane_Liste_Frekans]');
            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Eczane_Liste_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Eczane_Liste_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Eczane_Liste_Brick.empty();
                        Eczane_Liste_Brick.append("<option value='0'>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Liste_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Eczane_Liste_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Eczane_Liste_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Eczane_Liste_Brick.change(function () {
                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Listele',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).val() + "-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var temp = JSON.parse(data.d)

                        console.log(temp)
                        Eczane_Liste_Eczane.empty();
                        Eczane_Liste_Eczane.append("<option value='0'>Lütfen Eczane Seçiniz</option>");
                        for (var i = 0; i < temp.length; i++) {
                            Eczane_Liste_Eczane.append("<option value='" + temp[i].Eczane_Id + "'>" + temp[i].Eczane_Adı + "</option>");
                        }
                        if (Eczane_Liste_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Liste_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            });

            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Doktor_Liste_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Doktor_Liste_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Liste_Brick.empty();
                        Doktor_Liste_Brick.append("<option value='0'>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Liste_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Doktor_Liste_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Doktor_Liste_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Doktor_Liste_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '2-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Liste_Untie.empty();
                        Doktor_Liste_Untie.append("<option value='0'>Lütfen Ünite Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Liste_Untie.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Liste_Brick.parent().children().find($("select option:first-child")).html() == "Lütfen Brick Seçiniz") {
                            Doktor_Liste_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });//Doktor_Liste_Brans

            //#region Ziyaret_Edilen_Uniteler_Tablo_Doldur
            var Ziyaret_Edilen_Unite_Liste = [];
            $.ajax({
                url: 'Unite-Bazlı-Sipariş-Raporu.aspx/Ziyaret_Edilen_Üniteler',
                type: 'POST',
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    Ziyaret_Edilen_Unite_Liste = [];
                    var temp = JSON.parse(data.d);

                    for (var i = 0; i < temp.length; i++) {
                        var MyClass = {
                            Unite_Text: null,
                            Unite_Id: null,

                        }
                        MyClass.Unite_Text = temp[i].Unite_Text;
                        MyClass.Unite_Id = temp[i].Unite_Id;


                        Ziyaret_Edilen_Unite_Liste.push(MyClass);
                    }

                    Ziyaret_Edilen_Uniteler_Tablo_Doldur(Ziyaret_Edilen_Unite_Liste)



                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Ziyaret_Edilen_Uniteler_Tablo_Doldur(Ziyaret_Edilen_Unite_Liste)
            function Ziyaret_Edilen_Uniteler_Tablo_Doldur(Liste_) {
                $('#Ziyaret_Edilen_Uniteler').empty();

                $('#Ziyaret_Edilen_Uniteler').append('<table id="example_Ziyaret_Edilen" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Ünite Adı</th>' +
                    '<th>Ara</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody_Ziyaret_Edilen">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody_Ziyaret_Edilen]')



                    for (var i = 0; i < Liste_.length; i++) {

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Unite_Text + '</td>' +
                            '<td><a style="font-size: 20px; " id="Ünite_Seç" value="' + Liste_[i].Unite_Id + '"><i class="fa fa-search"></i></a></td>' +
                            '</tr>'
                        )
                    }


                }



                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Materyal-Talebi.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    global: false,
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

                $('#example_Ziyaret_Edilen').dataTable({

                    "lengthMenu": [3, 10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },

                });
                var Ünite_Seç_Tablo = $('a[id=Ünite_Seç]')
                Ünite_Seç_Tablo.click(function () {

                    var Unite_Id = $(this).attr('value');
                    Ünite_Seç(Unite_Id);
                    Ünite_Etrafın_Bulunan_Eczaneler_Ajax(Unite_Id);
                   
                })

            };



            //#endregion
            var Ziyaret_Edilen_Eczane_Liste = [];
            $.ajax({
                url: 'Eczane-Bazlı-Sipariş-Raporu.aspx/Ziyaret_Edilen_Eczaneler',
                type: 'POST',
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    Ziyaret_Edilen_Eczane_Liste = [];
                    var temp = JSON.parse(data.d);


                    for (var i = 0; i < temp.length; i++) {
                        var MyClass = {
                            Unite_Text: null,
                            Unite_Id: null,

                        }
                        MyClass.Unite_Text = temp[i].Unite_Text;
                        MyClass.Unite_Id = temp[i].Unite_Id;


                        Ziyaret_Edilen_Eczane_Liste.push(MyClass);
                    }

                    Ziyaret_Edilen_Eczane_Tablo_Doldur(Ziyaret_Edilen_Eczane_Liste)



                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Ziyaret_Edilen_Eczane_Tablo_Doldur(Ziyaret_Edilen_Eczane_Liste)
            function Ziyaret_Edilen_Eczane_Tablo_Doldur(Liste_) {
                $('#Ziyaret_Edilen_Eczaneler').empty();

                $('#Ziyaret_Edilen_Eczaneler').append('<table id="example_Ziyaret_Edilen_Eczane" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Eczane Adı</th>' +
                    '<th>Ara</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Tbody_Ziyaret_Edilen_Eczane">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Tbody_Ziyaret_Edilen_Eczane]')



                    for (var i = 0; i < Liste_.length; i++) {

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Unite_Text + '</td>' +
                            '<td><a style="font-size: 20px; " id="Eczane_Ekle_Tablo" value="' + Liste_[i].Unite_Id + '"><i class="fa fa-plus-square"></i></a></td>' +
                            '</tr>'
                        )
                    }


                }



                var Kullanıcı_Adı;
                $.ajax({
                    url: 'Materyal-Talebi.aspx/Kullanıcı_Adı_Soyadı',
                    type: 'POST',
                    data: "{'parametre': ''}",
                    async: false,
                    global: false,
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

                $('#example_Ziyaret_Edilen_Eczane').dataTable({

                    "lengthMenu": [3, 10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },

                });


                var Eczane_Ekle_Tablo = $('a[id=Eczane_Ekle_Tablo]')
                Eczane_Ekle_Tablo.click(function () {

                    var Eczane_Id = $(this).attr('value')

                    var Ünite_Şehir_Bilgi = $('input[id=Ünite_Şehir_Bilgi]')

                    var Unite_Id = Ünite_Şehir_Bilgi.attr('Unite_Id')
                   
                    Seçili_Eczaneye_Üniteye_Ekle(Unite_Id, Eczane_Id)
                   

                })

            };

            var Seç = $('input[id=Seç]')
            Seç.click(function () {
                var Unite_Id = Doktor_Liste_Untie.find('option:selected').attr('value');
                Ünite_Seç(Unite_Id);
                Ünite_Etrafın_Bulunan_Eczaneler_Ajax(Unite_Id);
            })


            function Ünite_Seç(Unite_Id) {

                var Ünite_Şehir_Bilgi = $('input[id=Ünite_Şehir_Bilgi]')
                var Ünite_İlçe_Bligi = $('input[id=Ünite_İlçe_Bligi]')
                var Ünite_Adı_Bilgi = $('input[id=Ünite_Adı_Bilgi]')
                Ünite_Şehir_Bilgi.attr('Unite_Id', Unite_Id)
                Ünite_İlçe_Bligi.attr('Unite_Id', Unite_Id)
                Ünite_Adı_Bilgi.attr('Unite_Id', Unite_Id)

                $.ajax({
                    url: 'Ünite-Etrafı-Eczane-Belirle.aspx/Ünite_Bilgileri',
                    type: 'POST',
                    async: false,
                    data:'{"Unite_Id":"'+Unite_Id+'"}',
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                       
                        var temp = JSON.parse(data.d);

                        console.log(temp)
                        if (temp.length>0) {
                            Ünite_Şehir_Bilgi.val(temp[0].Şehir)
                            Ünite_İlçe_Bligi.val(temp[0].Brick)
                            Ünite_Adı_Bilgi.val(temp[0].Unite_Text)
                        }
                      


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            }

            var Unite_Etrafında_Bulunan_Eczaneler_Liste = [];
            function Ünite_Etrafın_Bulunan_Eczaneler_Ajax(Unite_Id) {

                
                $.ajax({
                    url: 'Ünite-Etrafı-Eczane-Belirle.aspx/Ünite_Etrafındaki_Eczaneler',
                    type: 'POST',
                    async: false,
                    data: '{"Unite_Id":"' + Unite_Id + '"}',
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var temp = JSON.parse(data.d);
                        Unite_Etrafında_Bulunan_Eczaneler_Liste = [];
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {

                                Eczane_Adı: null,
                                Şehir: null,
                                Brick: null,
                                Eczane_Id: null,

                            }
                            MyClass.Eczane_Adı = temp[i].Eczane_Adı;
                            MyClass.Şehir = temp[i].Şehir;
                            MyClass.Brick = temp[i].Brick;
                            MyClass.Eczane_Id = temp[i].Eczane_Id;


                            Unite_Etrafında_Bulunan_Eczaneler_Liste.push(MyClass);
                        }

                        Ünite_Etrafında_Bulunan_Eczaneler_Tablo_Doldur(Unite_Etrafında_Bulunan_Eczaneler_Liste, Unite_Id)
                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            }


      
            Ünite_Etrafında_Bulunan_Eczaneler_Tablo_Doldur(Unite_Etrafında_Bulunan_Eczaneler_Liste)
            function Ünite_Etrafında_Bulunan_Eczaneler_Tablo_Doldur(Liste_,Unite_Id) {

                $('#Ünite_Etrafında_Bulunan_Eczaneler_Div').empty();
                $('#Ünite_Etrafında_Bulunan_Eczaneler_Div').append('<table id="Ünite_Etrafında_Bulunan_Eczaneler" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Eczane Adı</th>' +
                    '<th>Şehir</th>' +
                    '<th>Brick</th>' +
                    '<th>Sil</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Ünite_Etrafında_Bulunan_Eczaneler_Body">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Ünite_Etrafında_Bulunan_Eczaneler_Body]')



                    for (var i = 0; i < Liste_.length; i++) {

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Eczane_Adı + '</td>' +
                            '<td>' + Liste_[i].Şehir + '</td>' +
                            '<td>' + Liste_[i].Brick + '</td>' +
                            '<td><a style="font-size: 20px; " id="Eczaneyi_Kaldır" Unite_Id="' + Unite_Id + '" value="' + Liste_[i].Eczane_Id + '"><i class="fa fa-trash"></i></a></td>' +
                            '</tr>'
                        )
                    }


                }


    

                $('#Ünite_Etrafında_Bulunan_Eczaneler').dataTable({

                    "lengthMenu": [3, 10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },

                });


                var Eczaneyi_Kaldır = $('a[id=Eczaneyi_Kaldır]')
                Eczaneyi_Kaldır.click(function () {
                    var Unite_Id = $(this).attr('Unite_Id')
                    var Eczane_Id = $(this).attr('value')


                
                    $.ajax({
                        url: 'Ünite-Etrafı-Eczane-Belirle.aspx/Ünite_Etrafındaki_Eczaneyi_Kaldır',
                        type: 'POST',
                        async: false,
                        data: '{"Eczane_Id":"' + Eczane_Id +'","Unite_Id":"' + Unite_Id + '"}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Ünite_Etrafın_Bulunan_Eczaneler_Ajax(Unite_Id)

                      
                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                })



            };

            function Seçili_Eczaneye_Üniteye_Ekle(Unite_Id, Eczane_Id) {
                if (Unite_Id==undefined) {
                    var Ünite_Adı_Bilgi = $('input[id=Ünite_Adı_Bilgi]')
                    var Ünite_Şehir_Bilgi = $('input[id=Ünite_Şehir_Bilgi]')
                    var Ünite_İlçe_Bligi = $('input[id=Ünite_İlçe_Bligi]')

                    Ünite_Adı_Bilgi.parent().attr('class', 'form-group has-error')
                    Ünite_Şehir_Bilgi.parent().attr('class', 'form-group has-error')
                    Ünite_İlçe_Bligi.parent().attr('class', 'form-group has-error')


                }
                else {
                    var Ünite_Adı_Bilgi = $('input[id=Ünite_Adı_Bilgi]')
                    var Ünite_Şehir_Bilgi = $('input[id=Ünite_Şehir_Bilgi]')
                    var Ünite_İlçe_Bligi = $('input[id=Ünite_İlçe_Bligi]')
                    Ünite_Adı_Bilgi.parent().attr('class', 'form-group')
                    Ünite_Şehir_Bilgi.parent().attr('class', 'form-group')
                    Ünite_İlçe_Bligi.parent().attr('class', 'form-group')

                    $.ajax({
                        url: 'Ünite-Etrafı-Eczane-Belirle.aspx/Seçili_Eczaneye_Üniteye_Ekle',
                        type: 'POST',
                        async: false,
                        data: '{"Eczane_Id":"' + Eczane_Id + '","Unite_Id":"' + Unite_Id + '"}',
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {


                            if (data.d == "0") {
                                Swal.fire({
                                    title: 'Başarılı!',
                                    text: 'İşlem Başarı İle Kaydedildi',
                                    icon: 'success',
                                    confirmButtonText: 'Kapat'
                                })
                            }
                            if (data.d == "1") {
                                Swal.fire({
                                    title: 'Hata!',
                                    text: 'Eczane Daha Önceden Eklenmiş',
                                    icon: 'error',
                                    confirmButtonText: 'Kapat'
                                })
                            }

                            Ünite_Etrafın_Bulunan_Eczaneler_Ajax(Unite_Id)

                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }

               
            }


            var Ekle = $('input[id=Ekle]')
            Ekle.click(function () {

                var Ünite_Şehir_Bilgi = $('input[id=Ünite_Şehir_Bilgi]')

                var Unite_Id = Ünite_Şehir_Bilgi.attr('Unite_Id')
                var Eczane_Id = Eczane_Liste_Eczane.find('option:selected').attr('value');
                Seçili_Eczaneye_Üniteye_Ekle(Unite_Id, Eczane_Id)


            })

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="panel  panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen İL Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Doktor_Liste_Il" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen Brick Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Doktor_Liste_Brick" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen Ünite Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Doktor_Liste_Untie" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <input id="Seç" type="button" class="btn btn-block btn-info" value="Seç" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <label>Ziyaret Düzenlenmiş Üniteler</label>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div id="Ziyaret_Edilen_Uniteler"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <label>Seçili Ünite</label>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <label>Ünite Adı:</label>
                                        </div>
                                        <div class="col-xs-3">
                                            <label>Şehir: </label>
                                        </div>
                                        <div class="col-xs-3">
                                            <label>İlçe:</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <input type="text" id="Ünite_Adı_Bilgi" class="form-control" disabled="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="form-group">
                                                <input type="text" id="Ünite_Şehir_Bilgi" class="form-control" disabled="" />
                                            </div>
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="form-group">
                                                <input type="text" id="Ünite_İlçe_Bligi" class="form-control" disabled="" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="panel panel-default">
                                                <div class=" panel-heading">
                                                    <label>Ünite Etrafındaki Eczaneler</label>
                                                </div>
                                                <div class="panel-body">
                                                    <div id="Ünite_Etrafında_Bulunan_Eczaneler_Div"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen İL Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Eczane_Liste_Il" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen Brick Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Eczane_Liste_Brick" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <label>Lütfen Eczane Seçiniz</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <select name="Select" id="Eczane_Liste_Eczane" class="form-control"></select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <input class="btn btn-block btn-info" id="Ekle" value="Ekle" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <label>
                                        Ziyaret Düzenlenmiş Eczaneler
                                    </label>
                                </div>
                                <div class="panel-body">

                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div id="Ziyaret_Edilen_Eczaneler"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
