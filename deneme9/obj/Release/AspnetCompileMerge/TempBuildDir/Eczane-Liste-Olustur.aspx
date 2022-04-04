<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Eczane-Liste-Olustur.aspx.cs" Inherits="deneme9.Eczane_Liste_Olustur" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
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
            var Eczane_Liste_Ayarlar = $('select[id=Eczane_Liste_Ayarlar]')
            Eczane_Liste_Ayarlar.empty();
            Eczane_Liste_Ayarlar.append("<option value='0'>Lütfen Liste Seçiniz</option>");
            Eczane_Liste_Ayarlar.append('')

            Eczane_Liste_Ayarlar.change(function () {

                if ($('select[id=Eczane_Liste_Ayarlar]').find('option:selected').attr('value') == 0) {
                    var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                    Liste_Ad_Değiştir_İnput.attr('disabled', 'true')
                    Liste_Ad_Değiştir_İnput.attr('İşlem_Yapılsın', '0')
                }
                else {
                    var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                    Liste_Ad_Değiştir_İnput.removeAttr('disabled')
                    Liste_Ad_Değiştir_İnput.attr('İşlem_Yapılsın', '1')
                }

            })
            var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
            Liste_Ad_Değiştir_İnput.attr('disabled', 'true')
            $.ajax({
                url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)


                    for (var i = 0; i < temp.length; i++) {
                        Eczane_Liste_Ayarlar.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            var Liste_Ayarlar_Listeyi_Sil = $('button[id=Liste_Ayarlar_Listeyi_Sil]')
            Liste_Ayarlar_Listeyi_Sil.click(function () {

                if ($('input[id=Liste_Ad_Değiştir_İnput]').attr('İşlem_yapılsın') == "1") {



                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ad_Sil', //doktorları listelerken tersten listele
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Liste_Id': '" + $('select[id=Eczane_Liste_Ayarlar]').find('option:selected').attr('value') + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {


                            if (data.d == "0") {
                                Swal.fire({
                                    title: 'Başarılı!',
                                    text: 'İşlem Başarı İle Kaydedildi',
                                    icon: 'success',
                                    confirmButtonText: 'Kapat'
                                })
                                $('input[id=Liste_Ad_Değiştir_İnput]').val('')
                                var Eczane_Liste_Ayarlar = $('select[id=Eczane_Liste_Ayarlar]')
                                Eczane_Liste_Ayarlar.empty();
                                Eczane_Liste_Ayarlar.append("<option value='0'>Lütfen Liste Seçiniz</option>");
                                Eczane_Liste_Ayarlar.append('')

                                Eczane_Liste_Ayarlar.change(function () {

                                    if ($('select[id=Eczane_Liste_Ayarlar]').find('option:selected').attr('value') == 0) {
                                        var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                                        Liste_Ad_Değiştir_İnput.attr('disabled', 'true')
                                        Liste_Ad_Değiştir_İnput.attr('İşlem_Yapılsın', '0')
                                    }
                                    else {
                                        var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                                        Liste_Ad_Değiştir_İnput.removeAttr('disabled')
                                        Liste_Ad_Değiştir_İnput.attr('İşlem_Yapılsın', '1')
                                    }

                                })
                                var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                                Liste_Ad_Değiştir_İnput.attr('disabled', 'true')
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                                    dataType: 'json',
                                    type: 'POST',
                                    async: false,
                                    data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var temp = JSON.parse(data.d)


                                        for (var i = 0; i < temp.length; i++) {
                                            Eczane_Liste_Ayarlar.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                                        }
                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });

                                var Eczane_Liste_Olustur_Liste = $('select[id=Eczane_Liste_Olustur_Liste]');
                                Eczane_Liste_Olustur_Liste.empty();
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                                    dataType: 'json',
                                    type: 'POST',
                                    async: false,
                                    data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var temp = JSON.parse(data.d)


                                        for (var i = 0; i < temp.length; i++) {
                                            Eczane_Liste_Olustur_Liste.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                                        }
                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });
                                Listeyi_Doldur();



                            }
                            else {
                                Swal.fire({
                                    title: 'Hata!',
                                    text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                    icon: 'error',
                                    confirmButtonText: 'Kapat'
                                })
                            }

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
            })
            var Liste_Ayarlar_Listeyi_Kaydet = $('button[id=Liste_Ayarlar_Listeyi_Kaydet]')
            Liste_Ayarlar_Listeyi_Kaydet.click(function () {
                if ($('input[id=Liste_Ad_Değiştir_İnput]').attr('İşlem_yapılsın') == "1") {

                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ad_Değiştir', //doktorları listelerken tersten listele
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Liste_Id': '" + $('select[id=Eczane_Liste_Ayarlar]').find('option:selected').attr('value') + "','Liste_Yeni_Ad':'" + $('input[id=Liste_Ad_Değiştir_İnput]').val() + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {


                            if (data.d == "0") {
                                Swal.fire({
                                    title: 'Başarılı!',
                                    text: 'İşlem Başarı İle Kaydedildi',
                                    icon: 'success',
                                    confirmButtonText: 'Kapat'
                                })
                                $('input[id=Liste_Ad_Değiştir_İnput]').val('')
                                var Eczane_Liste_Ayarlar = $('select[id=Eczane_Liste_Ayarlar]')
                                Eczane_Liste_Ayarlar.empty();
                                Eczane_Liste_Ayarlar.append("<option value='0'>Lütfen Liste Seçiniz</option>");
                                Eczane_Liste_Ayarlar.append('')

                                Eczane_Liste_Ayarlar.change(function () {

                                    if ($('select[id=Eczane_Liste_Ayarlar]').find('option:selected').attr('value') == 0) {
                                        var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                                        Liste_Ad_Değiştir_İnput.attr('disabled', 'true')
                                        Liste_Ad_Değiştir_İnput.attr('İşlem_Yapılsın', '0')
                                    }
                                    else {
                                        var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                                        Liste_Ad_Değiştir_İnput.removeAttr('disabled')
                                        Liste_Ad_Değiştir_İnput.attr('İşlem_Yapılsın', '1')
                                    }

                                })
                                var Liste_Ad_Değiştir_İnput = $('input[id=Liste_Ad_Değiştir_İnput]')
                                Liste_Ad_Değiştir_İnput.attr('disabled', 'true')
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                                    dataType: 'json',
                                    type: 'POST',
                                    async: false,
                                    data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var temp = JSON.parse(data.d)


                                        for (var i = 0; i < temp.length; i++) {
                                            Eczane_Liste_Ayarlar.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                                        }
                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });

                                var Eczane_Liste_Olustur_Liste = $('select[id=Eczane_Liste_Olustur_Liste]');

                                Eczane_Liste_Olustur_Liste.empty();
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                                    dataType: 'json',
                                    type: 'POST',
                                    async: false,
                                    data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var temp = JSON.parse(data.d)


                                        for (var i = 0; i < temp.length; i++) {
                                            Eczane_Liste_Olustur_Liste.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                                        }
                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });




                            }
                            else {
                                Swal.fire({
                                    title: 'Hata!',
                                    text: 'Seçilen Tarihlerde Daha Önceden Ekleme Yapılmış Lütfen Kontrol Ediniz',
                                    icon: 'error',
                                    confirmButtonText: 'Kapat'
                                })
                            }

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
            })






            $("select[name=Şehir_Adı_Select2]").select2({
                placeholder: "Şehir Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })

            $("select[name=Semt_Adı_Select2]").select2({
                placeholder: "Brick Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
            })


            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Geçmiş_Şehir',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Şehir_Adı_Select2 = $('select[id=Şehir_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Şehir_Adı_Select2.append('<option value="' + temp[i].Şehir_Adı + '">' + temp[i].Şehir_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            //Brick Brick
            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Geçmiş_Brick',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Semt_Adı_Select2 = $('select[id=Semt_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Semt_Adı_Select2.append('<option value="' + temp[i].Brick_Adı + '">' + temp[i].Brick_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            var Liste_ = []
            Listeyi_Doldur_Arama(Liste_);
            function Listeyi_Doldur_Arama(Liste_) {

                $('#Tablo_Arama_Div').empty();

                $('#Tablo_Arama_Div').append('<table id="Arama_Table" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +

                    '                                            <th>Ad</th>' +
                    '                                            <th>İl</th>' +
                    '                                            <th>Brick</th>' +
                    '                                            <th>Ekle</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Arama_Body">' +
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
                    var Tbody = $('tbody[id=Arama_Body]')

                    for (var i = 0; i < Liste_.length; i++) {

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Doktor_Ad + '</td>' +
                            '<td>' + Liste_[i].CityName + '</td>' +
                            '<td>' + Liste_[i].TownName + '</td>' +
                            '<td>' + '<a value="' + Liste_[i].Doktor_Id + '" id="Doktoru_Ekle"><i class="fa fa fa-search"></i></a>' + '</td>' +

                            '</tr>'
                        )
                    }


                }



                $('#Arama_Table').dataTable({
                    "lengthMenu": [5, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    }
                });

                var Doktoru_Kaldır = $('a[id=Doktoru_Ekle]');
                Doktoru_Kaldır.click(function () {
                    var Eczane_Id_This = $(this).attr('value')
                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ekle_btn',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + $(this).attr('value') + "-" + "4" + "-" + $('select[id=Eczane_Liste_Olustur_Liste]').find('option:selected').attr('value') + "'}",

                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {


                            if (data.d == "0") {
                                alert("Eczane Daha Önceden Bu listeye eklenmiş")
                            }

                            if (data.d == "1") {

                                var Eczane_Duzenle = $('a[id=Eczane_Duzenle]')
                                Eczane_Duzenle.attr('Listedenmi', "1")
                                $('#Eczane_Eksik_Bilgi').modal('show')
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Bilgisi_Getir',
                                    dataType: 'json',
                                    type: 'POST',
                                    async: false,
                                    data: "{'Eczane_Id': '" + Eczane_Id_This + " '}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var temp = JSON.parse(data.d)

                                        $('a[id=Eczane_Duzenle]').attr("Eczane_id", temp[0].Eczane_Id)

                                        $('input[id=Default_Il]').val(temp[0].Eczane_İl)
                                        $('select[id=Düzenle_İl]').append("<option Eczane_İl_Id='" + temp[0].Eczane_Il_Id + "'>" + temp[0].Eczane_İl + "</option>")



                                        $('input[id=Default_Brick]').val(temp[0].Eczane_Brick)
                                        $('select[id=Düzenle_Brick]').append("<option Eczane_Brick_Id='" + temp[0].Eczane_Brick_Id + "'>" + temp[0].Eczane_Brick + "</option>")




                                        $('input[id=Default_Ad]').val(temp[0].Eczane_Adı)
                                        $('input[id=Düzenle_Ad]').val(temp[0].Eczane_Adı)

                                        $('input[id=Default_Tel]').val(temp[0].Eczane_Telefon)
                                        $('input[id=Düzenle_Tel]').val(temp[0].Eczane_Telefon)

                                        $('input[id=Default_Adres]').val(temp[0].Eczane_Adres)
                                        $('input[id=Düzenle_Adres]').val(temp[0].Eczane_Adres)

                                        $('input[id=Default_Eposta]').val(temp[0].Eposta)
                                        $('input[id=Düzenle_Eposta]').val(temp[0].Eposta)

                                        $('input[id=Default_Gln]').val(temp[0].Gln_No)
                                        $('input[id=Düzenle_Gln]').val(temp[0].Gln_No)


                                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                                    error: function () {
                                        //doktorları listelerken tersten listele 
                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });

                            }
                            Listeyi_Doldur();

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                });
            }



            $('button[id=Ara_Btn]').click(function () {

                var Şehir_Adı_Select2 = $('select[id=Şehir_Adı_Select2]')
                var Semt_Adı_Select2 = $('select[id=Semt_Adı_Select2]')

                //#region Urun_Adı



                //#endregion

                //#region Şehir

                var Şehir_Liste = [];
                if (Şehir_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Şehir_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Urun_Adı: null
                        }
                        Urun_Adı_Class.Urun_Adı = Şehir_Adı_Select2.val()[i];
                        Şehir_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Urun_Adı: null
                    }
                    Urun_Adı_Class.Urun_Adı = null;
                    Şehir_Liste.push(Urun_Adı_Class)
                }


                //#endregion

                //#region Semt

                var Semt_Liste = [];
                if (Semt_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Semt_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Semt: null
                        }
                        Urun_Adı_Class.Semt = Semt_Adı_Select2.val()[i];
                        Semt_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Semt: null
                    }
                    Urun_Adı_Class.Semt = null;
                    Semt_Liste.push(Urun_Adı_Class)
                }
                //#endregion

                //#region Depo

                //#endregion

                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Doktor_Listele',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{" +
                        "'Şehir':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'Semt':'{Semt_Liste:" + JSON.stringify(Semt_Liste) + "}'" +

                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Liste = [];
                        var temp = JSON.parse(data.d);

                        console.log(temp)
                        for (var i = 0; i < temp.length; i++) {
                            var MyClass = {
                                Doktor_Id: null,
                                Doktor_Ad: null,
                                Brans_Txt: null,
                                CityName: null,
                                TownName: null,
                                Unite_Txt: null,
                            }
                            MyClass.Doktor_Id = temp[i].Doktor_Id;
                            MyClass.Doktor_Ad = temp[i].Doktor_Ad;

                            MyClass.CityName = temp[i].CityName;
                            MyClass.TownName = temp[i].TownName;


                            Liste.push(MyClass);
                        }
                        Listeyi_Doldur_Arama(Liste);
                        console.log(Liste)

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                    }
                });








            })










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
            var tablo_kontrol = true;



            var Eczane_Liste_Olustur_Liste = $('select[id=Eczane_Liste_Olustur_Liste]');

            Eczane_Liste_Olustur_Liste.empty();
            $.ajax({
                url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)


                    for (var i = 0; i < temp.length; i++) {
                        Eczane_Liste_Olustur_Liste.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });



            Eczane_Liste_Olustur_Liste.change(function () {
                Listeyi_Doldur();
            });

            Listeyi_Doldur();

            function Listeyi_Doldur() {

                $('#Tablo_Div').empty();

                $('#Tablo_Div').append('<table id="example" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +

                    '                                            <th>Eczane Adı</th>' +
                    '                                            <th>Eczane Tipi</th>' +
                    '                                            <th>Brick</th>' +
                    '                                            <th>İl</th>' +
                    '                                            <th>Frekans</th>' +
                    '                                            <th>Kaldır</th>' +
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
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );




                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler_Tablo',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'Liste_Id': '" + Eczane_Liste_Olustur_Liste.find('option:selected').attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var temp = JSON.parse(data.d)
                        if (temp == "") {
                            tablo_kontrol = false;
                        }
                        var Tbody = $('tbody[id=Tbody]')

                        for (var i = 0; i < temp.length; i++) {

                            Tbody.append(
                                "<tr>" +
                                "<td>" + temp[i].Eczane + "</td>" +
                                "<td>" + temp[i].Eczane_Tip + "</td>" +
                                "<td>" + temp[i].TownName + "</td>" +
                                "<td>" + temp[i].CityName + "</td>" +
                                "<td>" + temp[i].Frekans + "</td>" +
                                "<td> <a style='font-size: 20px; ' id='Doktoru_Kaldır' value='" + temp[i].Eczane_Id + "'><i class='fa fa-trash-o'></i></a>  </td>" +
                                "</tr>"
                            )
                        }


                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

                $('#example').dataTable({
                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    }
                });
                var Doktoru_Kaldır = $('a[id=Doktoru_Kaldır]');
                Doktoru_Kaldır.click(function () {
                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Eczaneyi_Listeden_Kaldır',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + $(this).attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var Doktoru_Kaldır = Eczane_Listesi_Tablosu.children().find($('a[value=' + data.d + ']'))
                            if (data.d == "0") {
                                alert("İşlem Başarısız Lütfen Daha Sonra Tekrar Deneyiniz");
                            }
                            else {
                                Listeyi_Doldur()
                            }

                        }
                    });
                });
            }




            $('button[id=Doktor_Liste_Ayarları]').click(function () {

                $('div[id=Liste_Ayarlar]').modal('show')
            })




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

            Eczane_Liste_Eczane.change(function () {

                Eczane_Liste_Frekans.empty();
                Eczane_Liste_Frekans.append("<option value='0'>Lütfen Frekans Seçiniz</option>");
                Eczane_Liste_Frekans.append("<option value='2'>A  (Ayda 2 Kere Ziyaret)</option>");
                Eczane_Liste_Frekans.append("<option value='4'>B  (Ayda 4 Kere Ziyaret)</option>");
            });

            Eczane_Liste_Ekle_btn.click(function () {



                var Gönderilsinmi = true;
                var Kapansınmı = 0;
                $('select[name=Select_Tekli]').each(function () {
                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });

                if (Gönderilsinmi == true) {
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
                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ekle_btn',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + $('select[id=Eczane_Liste_Eczane]').find('option:selected').val() + "-" + "4" + "-" + $('select[id=Eczane_Liste_Olustur_Liste]').find('option:selected').attr('value') + "'}",

                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {


                            if (data.d == "0") {
                                alert("Eczane Daha Önceden Bu listeye eklenmiş")
                            }

                            if (data.d == "1") {

                                $('#Eczane_Eksik_Bilgi').modal('show')
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Bilgisi_Getir',
                                    dataType: 'json',
                                    type: 'POST',
                                    async: false,
                                    data: "{'Eczane_Id': '" + Eczane_Liste_Eczane.find('option:selected').val() + " '}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var temp = JSON.parse(data.d)

                                        $('a[id=Eczane_Duzenle]').attr("Eczane_id", temp[0].Eczane_Id)

                                        $('input[id=Default_Il]').val(temp[0].Eczane_İl)
                                        $('select[id=Düzenle_İl]').append("<option Eczane_İl_Id='" + temp[0].Eczane_Il_Id + "'>" + temp[0].Eczane_İl + "</option>")



                                        $('input[id=Default_Brick]').val(temp[0].Eczane_Brick)
                                        $('select[id=Düzenle_Brick]').append("<option Eczane_Brick_Id='" + temp[0].Eczane_Brick_Id + "'>" + temp[0].Eczane_Brick + "</option>")




                                        $('input[id=Default_Ad]').val(temp[0].Eczane_Adı)
                                        $('input[id=Düzenle_Ad]').val(temp[0].Eczane_Adı)

                                        $('input[id=Default_Tel]').val(temp[0].Eczane_Telefon)
                                        $('input[id=Düzenle_Tel]').val(temp[0].Eczane_Telefon)

                                        $('input[id=Default_Adres]').val(temp[0].Eczane_Adres)
                                        $('input[id=Düzenle_Adres]').val(temp[0].Eczane_Adres)

                                        $('input[id=Default_Eposta]').val(temp[0].Eposta)
                                        $('input[id=Düzenle_Eposta]').val(temp[0].Eposta)

                                        $('input[id=Default_Gln]').val(temp[0].Gln_No)
                                        $('input[id=Düzenle_Gln]').val(temp[0].Gln_No)



                                        $.ajax({
                                            url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ekle_btn',
                                            dataType: 'json',
                                            type: 'POST',
                                            data: "{'parametre': '" + $('select[id=Eczane_Liste_Eczane]').find('option:selected').val() + "-" + "4" + "-" + $('select[id=Eczane_Liste_Olustur_Liste]').find('option:selected').attr('value') + "'}",

                                            contentType: 'application/json; charset=utf-8',
                                            success: function (data) {


                                                if (data.d == "0") {
                                                    alert("Eczane Daha Önceden Bu listeye eklenmiş")
                                                }

                                                
                                                Listeyi_Doldur();

                                            },
                                            error: function () {

                                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                            }
                                        });


                                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                                    error: function () {
                                        //doktorları listelerken tersten listele 
                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });

                            }
                            Listeyi_Doldur();

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }


            });



            var Eczane_Duzenle = $('a[id=Eczane_Duzenle]')


            Eczane_Duzenle.click(function () {

                var Eczane_Id_This = $(this).attr("eczane_id")
                console.log($(this).attr("listedenmi"))
                if ($(this).attr("listedenmi") == "1") {
                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Düzenle_Gonder',
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Eczane_Id': '" + $(this).attr("eczane_id") + "'," +
                            "'Yerine_Ad':'" + $('input[id=Default_Ad]').val() + "'," +
                            "'Yerine_Brick':'" + $('select[id=Düzenle_Brick]').find('option:selected').attr("Eczane_Brick_Id") + "'," +
                            "'Yerine_İl':'" + $('select[id=Düzenle_İl]').find('option:selected').attr("Eczane_İl_Id") + "'," +
                            "'Yerine_Adres':'" + $('input[id=Düzenle_Adres]').val() + "'," +
                            "'Yerine_Telefon':'" + $('input[id=Düzenle_Tel]').val() + "'," +
                            "'Yerine_Tip':'" + $('select[id=Eczane_Tip]').find('option:selected').attr("value") + "'," +
                            "'Yerine_Gln':'" + $('input[id=Düzenle_Gln]').val() + "'," +
                            "'Yerine_Eposta':'" + $('input[id=Düzenle_Eposta]').val() + "'}",

                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            console.log("asdasd")
                            var temp = JSON.parse(data.d)
                            console.log(data.d)
                            try {
                                if (temp[0].Sonuç == "") {
                                    alert("İşlem Başarı İle iletildi")
                                }
                                if (temp[0].Sonuç == "1") {
                                    alert("Zaten Talep Oluşturulmuş")
                                }
                            } catch (e) {

                            }
                            var Gönderilsinmi = true;
                            var Kapansınmı = 0;
                            var Eczane_Tip = $('select[id=Eczane_Tip]')

                            if (Eczane_Tip.val() == "0" || Eczane_Tip.val() == null) {
                                Gönderilsinmi = false;
                                Eczane_Tip.parent().attr('class', 'form-group has-error')

                            }
                            else {
                                Eczane_Tip.parent().attr('class', 'form-group')
                                Kapansınmı++;
                            }


                            if (Gönderilsinmi == true) {
                                console.log(Eczane_Id_This)
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ekle_btn',
                                    dataType: 'json',
                                    type: 'POST',
                                    data: "{'parametre': '" + Eczane_Id_This + "-" + "4" + "-" + $('select[id=Eczane_Liste_Olustur_Liste]').find('option:selected').attr('value') + "'}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var Eczane_Duzenle = $('a[id=Eczane_Duzenle]')
                                        Eczane_Duzenle.attr('Listedenmi', "0")

                                        if (data.d == "0") {
                                            var Eczane_Duzenle = $('a[id=Eczane_Duzenle]')
                                            Eczane_Duzenle.attr('Listedenmi', "0")
                                            alert("Eczane Daha Önceden Bu listeye eklenmiş")
                                        }

                                        if (data.d == "1") {
                                            var Eczane_Duzenle = $('a[id=Eczane_Duzenle]')
                                            Eczane_Duzenle.attr('Listedenmi', "0")

                                            $('#Eczane_Eksik_Bilgi').modal('show')
                                            $.ajax({
                                                url: 'Eczane-Liste-Olustur.aspx/Eczane_Bilgisi_Getir',
                                                dataType: 'json',
                                                type: 'POST',
                                                async: false,
                                                data: "{'Eczane_Id': '" + Eczane_Liste_Eczane.find('option:selected').val() + " '}",
                                                contentType: 'application/json; charset=utf-8',
                                                success: function (data) {
                                                    var temp = JSON.parse(data.d)

                                                    $('a[id=Eczane_Duzenle]').attr("Eczane_id", temp[0].Eczane_Id)

                                                    $('input[id=Default_Il]').val(temp[0].Eczane_İl)
                                                    $('select[id=Düzenle_İl]').append("<option Eczane_İl_Id='" + temp[0].Eczane_Il_Id + "'>" + temp[0].Eczane_İl + "</option>")



                                                    $('input[id=Default_Brick]').val(temp[0].Eczane_Brick)
                                                    $('select[id=Düzenle_Brick]').append("<option Eczane_Brick_Id='" + temp[0].Eczane_Brick_Id + "'>" + temp[0].Eczane_Brick + "</option>")




                                                    $('input[id=Default_Ad]').val(temp[0].Eczane_Adı)
                                                    $('input[id=Düzenle_Ad]').val(temp[0].Eczane_Adı)

                                                    $('input[id=Default_Tel]').val(temp[0].Eczane_Telefon)
                                                    $('input[id=Düzenle_Tel]').val(temp[0].Eczane_Telefon)

                                                    $('input[id=Default_Adres]').val(temp[0].Eczane_Adres)
                                                    $('input[id=Düzenle_Adres]').val(temp[0].Eczane_Adres)

                                                    $('input[id=Default_Eposta]').val(temp[0].Eposta)
                                                    $('input[id=Düzenle_Eposta]').val(temp[0].Eposta)

                                                    $('input[id=Default_Gln]').val(temp[0].Gln_No)
                                                    $('input[id=Düzenle_Gln]').val(temp[0].Gln_No)


                                                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                                                error: function () {
                                                    //doktorları listelerken tersten listele 
                                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                                }
                                            });

                                        }
                                        Listeyi_Doldur();

                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });
                            }

                            $('#Eczane_Eksik_Bilgi').modal('toggle')

                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {
                            //doktorları listelerken tersten listele 
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
                else {



                    if ($('select[id=Eczane_Tip]').find('option:selected').attr("value") != "0" && $('select[id=Eczane_Tip]').find('option:selected').attr("value") != undefined) {
                        $.ajax({
                            url: 'Eczane-Liste-Olustur.aspx/Eczane_Düzenle_Gonder',
                            dataType: 'json',
                            type: 'POST',
                            async: false,
                            data: "{'Eczane_Id': '" + $(this).attr("eczane_id") + "'," +
                                "'Yerine_Ad':'" + $('input[id=Default_Ad]').val() + "'," +
                                "'Yerine_Brick':'" + $('select[id=Düzenle_Brick]').find('option:selected').attr("Eczane_Brick_Id") + "'," +
                                "'Yerine_İl':'" + $('select[id=Düzenle_İl]').find('option:selected').attr("Eczane_İl_Id") + "'," +
                                "'Yerine_Adres':'" + $('input[id=Düzenle_Adres]').val() + "'," +
                                "'Yerine_Telefon':'" + $('input[id=Düzenle_Tel]').val() + "'," +
                                "'Yerine_Tip':'" + $('select[id=Eczane_Tip]').find('option:selected').attr("value") + "'," +
                                "'Yerine_Gln':'" + $('input[id=Düzenle_Gln]').val() + "'," +
                                "'Yerine_Eposta':'" + $('input[id=Düzenle_Eposta]').val() + "'}",

                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                console.log("asdasd")
                                var temp = JSON.parse(data.d)
                                console.log(data.d)
                                try {
                                    if (temp[0].Sonuç == "") {
                                        alert("İşlem Başarı İle iletildi")
                                    }
                                    if (temp[0].Sonuç == "1") {
                                        alert("Zaten Talep Oluşturulmuş")
                                    }
                                } catch (e) {

                                }
                                var Gönderilsinmi = true;
                                var Kapansınmı = 0;
                                $('select[name=Select_Tekli]').each(function () {

                                    if ($(this).val() == "0" || $(this).val() == null) {
                                        Gönderilsinmi = false;
                                        $(this).parent().attr('class', 'form-group has-error')
                                        Kapansınmı++;
                                    }
                                    else {
                                        $(this).parent().attr('class', 'form-group')
                                    }

                                });

                                if (Gönderilsinmi == true) {
                                    $.ajax({
                                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ekle_btn',
                                        dataType: 'json',
                                        type: 'POST',
                                        data: "{'parametre': '" + Eczane_Id_This + "-" + "4" + "-" + $('select[id=Eczane_Liste_Olustur_Liste]').find('option:selected').attr('value') + "'}",
                                        contentType: 'application/json; charset=utf-8',
                                        success: function (data) {


                                            if (data.d == "0") {
                                                alert("Eczane Daha Önceden Bu listeye eklenmiş")
                                            }

                                            if (data.d == "1") {

                                                $('#Eczane_Eksik_Bilgi').modal('show')
                                                $.ajax({
                                                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Bilgisi_Getir',
                                                    dataType: 'json',
                                                    type: 'POST',
                                                    async: false,
                                                    data: "{'Eczane_Id': '" + Eczane_Liste_Eczane.find('option:selected').val() + " '}",
                                                    contentType: 'application/json; charset=utf-8',
                                                    success: function (data) {
                                                        var temp = JSON.parse(data.d)

                                                        $('a[id=Eczane_Duzenle]').attr("Eczane_id", temp[0].Eczane_Id)

                                                        $('input[id=Default_Il]').val(temp[0].Eczane_İl)
                                                        $('select[id=Düzenle_İl]').append("<option Eczane_İl_Id='" + temp[0].Eczane_Il_Id + "'>" + temp[0].Eczane_İl + "</option>")



                                                        $('input[id=Default_Brick]').val(temp[0].Eczane_Brick)
                                                        $('select[id=Düzenle_Brick]').append("<option Eczane_Brick_Id='" + temp[0].Eczane_Brick_Id + "'>" + temp[0].Eczane_Brick + "</option>")




                                                        $('input[id=Default_Ad]').val(temp[0].Eczane_Adı)
                                                        $('input[id=Düzenle_Ad]').val(temp[0].Eczane_Adı)

                                                        $('input[id=Default_Tel]').val(temp[0].Eczane_Telefon)
                                                        $('input[id=Düzenle_Tel]').val(temp[0].Eczane_Telefon)

                                                        $('input[id=Default_Adres]').val(temp[0].Eczane_Adres)
                                                        $('input[id=Düzenle_Adres]').val(temp[0].Eczane_Adres)

                                                        $('input[id=Default_Eposta]').val(temp[0].Eposta)
                                                        $('input[id=Düzenle_Eposta]').val(temp[0].Eposta)

                                                        $('input[id=Default_Gln]').val(temp[0].Gln_No)
                                                        $('input[id=Düzenle_Gln]').val(temp[0].Gln_No)


                                                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                                                    error: function () {
                                                        //doktorları listelerken tersten listele 
                                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                                    }
                                                });

                                            }
                                            Listeyi_Doldur();

                                        },
                                        error: function () {

                                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                        }
                                    });
                                }

                                $('#Eczane_Eksik_Bilgi').modal('toggle')

                            },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                            error: function () {
                                //doktorları listelerken tersten listele 
                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });
                    }
                }
            })

            function Tablo_Listesini_Doldur() {
                $.ajax({
                    url: 'Sipariş-Onay.aspx/Tablo_Verisi',
                    type: 'POST',
                    data: "{'Tar_1': '" + TextBox2.val() + "','Tar_2':'" + TextBox3.val() + "'}",
                    async: false,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var temp = JSON.parse(data.d)
                        Liste = [];

                        for (var i = 0; i < temp.length; i++) {

                            var MyClass = {
                                Eczane_Adı: null,
                                Şehir: null,
                                Brick: null,
                                Tar: null,
                                Onay_Durum: null,
                                Detay: null,
                                Kullanıcı_Ad_Soyad: null,
                                Sil: null,
                                İletim_Durum: null,
                                Onaylanmadıya_Düştümü: null,
                                Sipariş_Tekrar_Gönderlidimi: null

                            }

                            MyClass.Eczane_Adı = temp[i].Eczane_Adı
                            MyClass.Şehir = temp[i].CityName
                            MyClass.Brick = temp[i].TownName
                            MyClass.Tar = temp[i].Tar
                            MyClass.Onay_Durum = temp[i].Onay_Durum
                            MyClass.Detay = temp[i].Siparis_Genel_Id
                            MyClass.Sil = temp[i].Siparis_Genel_Id
                            MyClass.Kullanıcı_Ad_Soyad = temp[i].Kullanıcı_Ad_Soyad
                            MyClass.İletim_Durum = temp[i].İletim_Durum
                            MyClass.Onaylanmadıya_Düştümü = temp[i].Onaylanmadıya_Düştümü
                            MyClass.Sipariş_Tekrar_Gönderlidimi = temp[i].Sipariş_Tekrar_Gönderlidimi


                            Liste.push(MyClass);

                        }

                        Tabloyu_Doldur(Liste)




                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            }

            Eczane_Yeni_Liste_Olustur_Modal_btn.click(function () {


                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Liste_Ekle',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Eczane_Yeni_Liste_Input.val() + "-" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Eczane_Liste_Olustur_Liste.append("<option value='" + data.d + "'>" + Eczane_Yeni_Liste_Input.val() + "</option>")

                        Eczane_Liste_Olustur_Liste.find($('option[value=' + data.d + ']')).attr('selected', 'selected');


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        //doktorları listelerken tersten listele 
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });




        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Liste_Ayarlar" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Liste Ayarları</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <select name="Select_Ayar" id="Eczane_Liste_Ayarlar" class="form-control"></select>
                    </div>
                    <div class="form-group">
                        <label>Liste Adı Değiştir</label>
                        <input id="Liste_Ad_Değiştir_İnput" type="text" class="form-control" placeholder="4 Frekans Doktorlar . . ." />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" data-dismiss="modal" class="btn btn-default" data-dismiss="modal">Kapat</button>
                    <button id="Liste_Ayarlar_Listeyi_Sil" type="button" class="btn btn-danger">Listeyi Sil</button>
                    <button id="Liste_Ayarlar_Listeyi_Kaydet" type="button" class="btn btn-info">Kaydet</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="Eczane_Eksik_Bilgi" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title" id="İşlem_Başarılı_label">Eczane Düzenle</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Default_Il" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Düzenle_İl" class="form-control" disabled></select>
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
                                    <input name="Ekle_İnput" id="Default_Brick" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Düzenle_Brick" class="form-control" disabled></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Adı Griniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Default_Ad" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Düzenle_Ad" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Tipi Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group has-error">
                                    <select id="Eczane_Tip" class="form-control">
                                        <option value="0">Lütfen Eczane Tipi Seçiniz</option>
                                        <option value="1">AVM Kenarı</option>
                                        <option value="2">Semt Eczanesi</option>
                                        <option value="3">Cadde Eczanesi</option>
                                        <option value="4">Unite Kenarı</option>
                                        <option value="5">ASM İçi </option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Telefon No. Griniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Default_Tel" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Düzenle_Tel" type="text" class="form-control" disabled></input>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Adresi Griniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Default_Adres" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Düzenle_Adres" type="text" class="form-control" disabled></input>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eposta Adresi Griniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Default_Eposta" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Düzenle_Eposta" type="text" class="form-control" disabled></input>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen GLN No Griniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Default_Gln" type="text" class="form-control" disabled />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Düzenle_Gln" type="text" class="form-control" disabled></input>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <a id="Eczane_Duzenle" class="btn btn-info pull-right">Eczaneyi Düzenleme Talebi Gönder</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div id="Eczane_Yeni_Liste_Ekle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lütfen Liste Adı Giriniz</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Liste Adı</label>
                        <input id="Eczane_Yeni_Liste_Input" type="text" class="form-control" placeholder="4 Frekans Eczaneler . . ." />
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="Eczane_Yeni_Liste_Olustur_Modal_btn" type="button" class="btn btn-default" data-dismiss="modal">Ekle</button>
                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-xs-6">
            <div class="form-group">
                <select name="Select" id="Eczane_Liste_Olustur_Liste" class="form-control"></select>
            </div>
        </div>
        <div class="col-xs-3">
            <div class="form-group">
                <button type="button" class="btn btn-info btn-block" data-toggle="modal" data-target="#Eczane_Yeni_Liste_Ekle_Modal">Yeni Liste Oluştur</button>
            </div>
        </div>
        <div class="col-xs-3">
            <div class="form-group">
                <button id="Doktor_Liste_Ayarları" type="button" class="btn btn-info btn-block">Ayarlar</button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="box">
                <div class="box-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label>Filtrele</label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-6">
                                    <label>Şehir :</label>
                                </div>
                                <div class="col-xs-6">
                                    <label>Brick :</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <select name="Şehir_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Şehir_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-6">
                                    <select name="Semt_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Semt_Adı_Select2" multiple="multiple"></select>
                                </div>
                            </div>
                            <div class="row" style="">
                                <div class="col-xs-4 text-center">
                                    <label></label>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <button id="Ara_Btn" type="button" class="btn btn-block btn-info">Ara</button>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div id="Tablo_Arama_Div"></div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box box-info box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">Eczane Listesi Oluştur</h3>
                    <div class="box-tools pull-right">
                    </div>
                    <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen İL Seçiniz</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <select name="Select_Tekli" id="Eczane_Liste_Il" class="form-control"></select>
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
                                <select name="Select_Tekli" id="Eczane_Liste_Brick" class="form-control"></select>
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
                                <select name="Select_Tekli" id="Eczane_Liste_Eczane" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <a id="Eczane_Liste_Ekle_btn" class="btn btn-info pull-right">Seçilen Eczaneyi Listeye Ekle</a>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <label>Filtrele</label>
                        </div>
                        <div class="panel-body">
                            <div id="Tablo_Div">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
