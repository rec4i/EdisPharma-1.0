<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Doktor-Listesi-Olustur.aspx.cs" Inherits="deneme9.Doktor_Ekle_Cıkar1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
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
                url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele
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
                                    url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele
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

                                var Eczane_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');
                                Eczane_Liste_Olustur_Liste.empty();
                                $.ajax({
                                    url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele
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
                                    url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele
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

                                var Eczane_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');

                                Eczane_Liste_Olustur_Liste.empty();
                                $.ajax({
                                    url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele
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




            $("select[name=Urun_Adı_Select2]").select2({
                placeholder: "Ünite Adı Seçiniz",
                "language": {
                    "noResults": function () {
                        return "Sonuç Bulunamadı";
                    }
                },
                ajax: {
                    url: "Doktor-Listesi-Olustur.aspx/Unite_Adı_Getir",
                    dataType: 'json',
                    type: 'POST',
                    delay: 250,
                    global: false,
                    contentType: "application/json; charset=utf-8",
                    data: function (params) {
                        return '{"Harf":"' + params.term + '"}'
                    },
                    processResults: function (data, params) {

                        return {
                            results: $.map(JSON.parse(data.d), function (item) {

                                return {
                                    text: item.LastName,
                                    id: item.Id
                                }
                            })
                        };
                    },
                    cache: true
                },
                minimumInputLength: 2


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

            $("select[name=Depo_Adı_Select2]").select2({
                placeholder: "Branş Seçiniz",
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


            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Geçmiş_Depo',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Depo_Adı_Select2 = $('select[id=Depo_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Depo_Adı_Select2.append('<option value="' + temp[i].Depo_Adı + '">' + temp[i].Depo_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Geçmiş_Urun_Adı',
                dataType: 'json',
                type: 'POST',
                data: "{'Paramatre':''}",
                async: false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Liste_İncele_Düzenle = [];
                    var temp = JSON.parse(data.d);

                    var Urun_Adı_Select2 = $('select[id=Urun_Adı_Select2]')
                    for (var i = 0; i < temp.length; i++) {
                        Urun_Adı_Select2.append('<option value="' + temp[i].Urun_Adı + '">' + temp[i].Urun_Adı + '</option>')
                    }

                },
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            $('button[id=Ara_Btn]').click(function () {

                var Urun_Adı_Select2 = $('select[id=Urun_Adı_Select2]')
                var Şehir_Adı_Select2 = $('select[id=Şehir_Adı_Select2]')
                var Semt_Adı_Select2 = $('select[id=Semt_Adı_Select2]')
                var Depo_Adı_Select2 = $('select[id=Depo_Adı_Select2]')

                //#region Urun_Adı


                var Urun_Adı_Liste = [];
                if (Urun_Adı_Select2.val().length > 0) {
                    var data = Urun_Adı_Select2.select2('data');
                    for (var i = 0; i < Urun_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Urun_Adı: null
                        }
                        Urun_Adı_Class.Urun_Adı = data[i].text;
                        Urun_Adı_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Urun_Adı: null
                    }
                    Urun_Adı_Class.Urun_Adı = null;
                    Urun_Adı_Liste.push(Urun_Adı_Class)
                }
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

                var Depo_Adı_Liste = [];
                if (Depo_Adı_Select2.val().length > 0) {
                    for (var i = 0; i < Depo_Adı_Select2.val().length; i++) {
                        var Urun_Adı_Class = {
                            Depo_Adı_: null
                        }
                        Urun_Adı_Class.Depo_Adı_ = Depo_Adı_Select2.val()[i];
                        Depo_Adı_Liste.push(Urun_Adı_Class)
                    }
                }
                else {
                    var Urun_Adı_Class = {
                        Depo_Adı_: null
                    }
                    Urun_Adı_Class.Depo_Adı_ = null;
                    Depo_Adı_Liste.push(Urun_Adı_Class)
                }
                //#endregion

                $.ajax({
                    url: 'Doktor-Listesi-Olustur.aspx/Doktor_Listele',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{'Unite_Adı': '{Urun_Adı_Liste:" + JSON.stringify(Urun_Adı_Liste) + "}'," +
                        "'Şehir':'{Şehir_Liste:" + JSON.stringify(Şehir_Liste) + "}'," +
                        "'Semt':'{Semt_Liste:" + JSON.stringify(Semt_Liste) + "}'," +
                        "'Branş':'{Depo_Liste:" + JSON.stringify(Depo_Adı_Liste) + "}'" +
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
                            MyClass.Brans_Txt = temp[i].Brans_Txt;
                            MyClass.CityName = temp[i].CityName;
                            MyClass.TownName = temp[i].TownName;
                            MyClass.Unite_Txt = temp[i].Unite_Txt;

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















            var Doktor_Yeni_Liste_Olustur_Modal_btn = $('button[id=Doktor_Yeni_Liste_Olustur_Modal_btn]'); //doktorları listelerken tersten listele 
            var Doktor_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');
            var Doktor_Yeni_Liste_Input = $('input[id=Doktor_Yeni_Liste_Input]');
            var Doktor_Listesi_Tablosu = $('tbody[id=Doktor_Listesi_Tablosu_Body]');
            var Doktor_Liste_Ekle_btn = $('a[id=Doktor_Liste_Ekle_btn]') //doktorları listelerken tersten listele 
            var Doktor_Liste_Il = $('select[id=Doktor_Liste_Il]');
            Doktor_Liste_Il.append("<option value='0'>Lütfen İl Seçiniz</option>");
            var Doktor_Liste_Brick = $('select[id=Doktor_Liste_Brick]');
            var Doktor_Liste_Untie = $('select[id=Doktor_Liste_Untie]');
            var Doktor_Liste_Brans = $('select[id=Doktor_Liste_Brans]');
            var Doktor_Liste_Doktor_Ad = $('select[id=Doktor_Liste_Doktor_Ad]');
            var Doktor_Liste_Frekans = $('select[id=Doktor_Liste_Frekans]');
            var tablo_kontrol = true;



            //doktorları listelerken tersten listele 
            Doktor_Liste_Olustur_Liste.empty()




            $.ajax({
                url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'Liste_Adı': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    for (var i = 0; i < temp.length; i++) {
                        Doktor_Liste_Olustur_Liste.append("<option value='" + temp[i].Liste_Id + "'>" + temp[i].Liste_Ad + "</option>");
                    }

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Doktor_Liste_Olustur_Liste.change(function () {
                Listeyi_Doldur();
            })
            Listeyi_Doldur();
            //doktorları listelerken tersten listele 

            $('button[id=Doktor_Liste_Ayarları]').click(function () {

                $('div[id=Liste_Ayarlar]').modal('show')
            })
            var Liste_=[]
            Listeyi_Doldur_Arama(Liste_);
            function Listeyi_Doldur_Arama(Liste_) {

                $('#Tablo_Arama_Div').empty();

                $('#Tablo_Arama_Div').append('<table id="Arama_Table" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +

                    '                                            <th>Ad</th>' +
                    '                                            <th>Branş</th>' +
                    '                                            <th>Ünite</th>' +
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
                            '<td>' + Liste_[i].Brans_Txt + '</td>' +
                            '<td>' + Liste_[i].CityName + '</td>' +
                            '<td>' + Liste_[i].TownName + '</td>' + 
                            '<td>' + Liste_[i].Unite_Txt + '</td>' +
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
                    var Doktor_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');
                    $.ajax({
                        url: 'Doktor-Listesi-Olustur.aspx/Doktor_Liste_Ekle_btn',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Doktor_Liste': '" + Doktor_Liste_Olustur_Liste.find('option:selected').attr('value') + "'," +
                            "'Doktor_Ad':'" + $(this).attr('value') + "'," +
                            "'Doktor_Frekans':'4'}",
                        contentType: 'application/json; charset=utf-8',

                        success: function (data) {
                            if (data.d == "0") {
                                alert("Doktor Daha Önceden Bu listeye eklenmiş")
                            }
                            else {
                                Listeyi_Doldur();
                            }

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                });
            }

            function Listeyi_Doldur() {

                $('#Tablo_Div').empty();

                $('#Tablo_Div').append('<table id="example" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +

                    '                                            <th>Doktor Adı</th>' +
                    '                                            <th>Branş</th>' +
                    '                                            <th>Ünite</th>' +
                    '                                            <th>Brick</th>' +
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
                    url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Listeler_Tablo',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'parametre': '" + Doktor_Liste_Olustur_Liste.find('option:selected').attr('value') + "-" + "'}",
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
                                "<td>" + temp[i].Doktor_Adı + "</td>" +
                                "<td>" + temp[i].Doktor_Branş + "</td>" +
                                "<td>" + temp[i].Doktor_Unite + "</td>" +
                                "<td>" + temp[i].Doktor_Brick + "</td>" +
                                "<td>" + temp[i].Doktor_Frekans + "</td>" +
                                "<td> <a style='font-size: 20px; ' id='Doktoru_Kaldır' value='" + temp[i].Doktor_Id + "'><i class='fa fa-trash-o'></i></a>  </td>" +
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
                        url: 'Doktor-Listesi-Olustur.aspx/Doktoru_Listeden_Kaldır',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + $(this).attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var Doktoru_Kaldır = Doktor_Listesi_Tablosu.children().find($('a[value=' + data.d + ']'))

                            if (data.d == "0") {
                                alert("İşlem Başarısız Lütfen Daha Sonra Tekrar Deneyiniz");
                            }
                            else {
                                Listeyi_Doldur();
                            }

                        }
                    });

                });
            }


            $.ajax({
                url: 'ddldeneme.aspx/Şehir_Getir',
                dataType: 'json',
                type: 'POST',
                data: "{}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var temp = JSON.parse(data.d)

                    Doktor_Liste_Il.empty();
                    Doktor_Liste_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")

                    for (var i = 0; i < temp.length; i++) {
                        Doktor_Liste_Il.append("<option value='" + temp[i].Şehir_Id + "'>" + temp[i].Şehir_Name + "</option>");
                    }


                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Doktor_Liste_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/Brick_Getir',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Şehir_Id': '" + $(this).find('option:selected').attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)


                        Doktor_Liste_Brick.empty();
                        Doktor_Liste_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");

                        for (var i = 0; i < temp.length; i++) {
                            Doktor_Liste_Brick.append("<option value='" + temp[i].Brick_Id + "'>" + temp[i].Brick_Name + "</option>");
                        }

                        if (Doktor_Liste_Il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Doktor_Liste_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Doktor_Liste_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/Unite_Getir',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Brick_Id': '" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)

                        Doktor_Liste_Untie.empty();
                        Doktor_Liste_Untie.append("<option>-->> Lütfen Ünite Seçiniz <<--</option>");


                        for (var i = 0; i < temp.length; i++) {
                            Doktor_Liste_Untie.append("<option value='" + temp[i].Unite_Id + "'>" + temp[i].Unite_Name + "</option>");
                        }


                        if (Doktor_Liste_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Brick Seçiniz &lt;&lt;--") {
                            Doktor_Liste_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });//Doktor_Liste_Brans
            Doktor_Liste_Untie.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/Branş_Getir',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Unite_Id': '" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)
                        Doktor_Liste_Brans.empty();
                        Doktor_Liste_Brans.append("<option>-->> Lütfen Branş Seçiniz <<--</option>");

                        for (var i = 0; i < temp.length; i++) {
                            Doktor_Liste_Brans.append("<option value='" + temp[i].Branş_Id + "'>" + temp[i].Branş_Name + "</option>");
                        }



                        if (Doktor_Liste_Untie.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Ünite Seçiniz &lt;&lt;--") {
                            Doktor_Liste_Untie.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });

            Doktor_Liste_Brans.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/Doktor_Getir_Listesiz',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Branş_Id': '" + $(this).val() + "','Unite_Id':'" + Doktor_Liste_Untie.find('option:selected').attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {


                        var temp = JSON.parse(data.d)


                        Doktor_Liste_Doktor_Ad.empty();
                        Doktor_Liste_Doktor_Ad.append(" <option value='0'>-->> Lütfen Doktor Adı Seçiniz <<--</option>");

                        for (var i = 0; i < temp.length; i++) {
                            Doktor_Liste_Doktor_Ad.append("<option frekans=" + temp[i].Doktor_Frekans + " value='" + temp[i].Doktor_Id + "'>" + temp[i].Doktor_Name + "</option>");


                        }


                        if (Doktor_Liste_Brans.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Branş Seçiniz &lt;&lt;--") {
                            Doktor_Liste_Brans.parent().children().find($("select option:first-child")).remove();
                        }



                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });// sadece 1 kere silecek şekilde ayarla sikim

            });//Doktor_Liste_Frekans 
            Doktor_Liste_Doktor_Ad.change(function () {
                Doktor_Liste_Frekans.empty();
                Doktor_Liste_Frekans.append(" <option value='0'>Lütfen Frekans Seçiniz</option>");
                Doktor_Liste_Frekans.append(" <option value='2'>A  (Ayda 2 Kere Ziyaret)</option>");
                Doktor_Liste_Frekans.append(" <option value='4'>B  (Ayda 4 Kere Ziyaret)</option>");
            });
            Doktor_Liste_Ekle_btn.click(function () {
                var Gönderilsinmi = true;
                $('select[name=Select_Tekli]').each(function () {
                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        console.log("asd")

                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });
                console.log(Gönderilsinmi)
                if (Gönderilsinmi == true) {
                    var Doktor_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');
                    $.ajax({
                        url: 'Doktor-Listesi-Olustur.aspx/Doktor_Liste_Ekle_btn',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Doktor_Liste': '" + Doktor_Liste_Olustur_Liste.find('option:selected').attr('value') + "'," +
                            "'Doktor_Ad':'" + Doktor_Liste_Doktor_Ad.find('option:selected').attr('value') + "'," +
                            "'Doktor_Frekans':'4'}",
                        contentType: 'application/json; charset=utf-8',

                        success: function (data) {
                            if (data.d == "0") {
                                alert("Doktor Daha Önceden Bu listeye eklenmiş")
                            }
                            else {
                                Listeyi_Doldur();
                            }

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }




            });


            Doktor_Yeni_Liste_Olustur_Modal_btn.click(function () {


                //Doktor_Yeni_Liste_Input.val() //doktorları listelerken tersten listele 

                $.ajax({
                    url: 'Doktor-Listesi-Olustur.aspx/Yeni_Liste_Olustur_Liste_Ekle',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Liste_Adı': '" + Doktor_Yeni_Liste_Input.val() +  "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var temp = JSON.parse(data.d)

                        Doktor_Liste_Olustur_Liste.append("<option value='" + temp[0].Liste_Id + "'>" + Doktor_Yeni_Liste_Input.val() + "</option>")

                       Doktor_Liste_Olustur_Liste.find($('option[value=' + temp[0].Liste_Id + ']')).attr('selected', 'selected');

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        //doktorları listelerken tersten listele 
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });



        });
         //doktorları listelerken tersten listele
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Doktor_Yeni_Liste_Ekle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lütfen Liste Adı Giriniz</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Liste Adı</label>
                        <input id="Doktor_Yeni_Liste_Input" type="text" class="form-control" placeholder="4 Frekans Doktorlar . . ." />
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="Doktor_Yeni_Liste_Olustur_Modal_btn" type="button" class="btn btn-default" data-dismiss="modal">Ekle</button>
                </div>
            </div>
        </div>
    </div>
    <div id="Liste_Ayarlar" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lütfen Liste Adı Giriniz</h4>
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
                    <button id="Liste_Ayarlar_Listeyi_Sil" type="button" class="btn btn-danger" >Listeyi Sil</button>
                    <button id="Liste_Ayarlar_Listeyi_Kaydet" type="button" class="btn btn-info">Kaydet</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="row">
                <div class="col-xs-12">
                    <label>Lütfen Liste Belirleyiniz</label>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <select id="Doktor_Liste_Olustur_Liste" class="form-control"></select>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <button id="Doktor_Yeni_Liste_Olustur" type="button" class="btn btn-info btn-block " data-toggle="modal" data-target="#Doktor_Yeni_Liste_Ekle_Modal">Yeni Liste Oluştur</button>
                    </div>
                </div>
                <div class="col-xs-3">
                    <div class="form-group">
                        <button id="Doktor_Liste_Ayarları" type="button" class="btn btn-info btn-block">Ayarlar</button>
                    </div>
                </div>
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
                                <div class="col-xs-3">
                                    <label>Ünite :</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Şehir :</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Brick :</label>
                                </div>
                                <div class="col-xs-3">
                                    <label>Branş :</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3">
                                    <select name="Urun_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Urun_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-3">
                                    <select name="Şehir_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Şehir_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-3">
                                    <select name="Semt_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Semt_Adı_Select2" multiple="multiple"></select>
                                </div>
                                <div class="col-xs-3">
                                    <select name="Depo_Adı_Select2" class="js-example-placeholder-multiple js-states form-control" id="Depo_Adı_Select2" multiple="multiple"></select>
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
            <div class="row">
                <div class="col-lg-12">
                    <div class="box box-info box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">Doktor Ekle</h3>
                            <div class="box-tools pull-right">
                            </div>
                        </div>
                        <div class="box-body">

                            <div class="row">
                                <div class="col-xs-12">
                                    <label>Lütfen İL Seçiniz</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <select name="Select_Tekli" id="Doktor_Liste_Il" class="form-control"></select>
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
                                        <select name="Select_Tekli" id="Doktor_Liste_Brick" class="form-control"></select>
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
                                        <select name="Select_Tekli" id="Doktor_Liste_Untie" class="form-control"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <label>Lütfen Branş Seçiniz</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <select name="Select_Tekli" id="Doktor_Liste_Brans" class="form-control"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <label>Lütfen Doktor Seçiniz</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <select name="Select_Tekli" id="Doktor_Liste_Doktor_Ad" class="form-control"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <label>Lütfen Frekans Seçiniz</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <a id="Doktor_Liste_Ekle_btn" class="btn btn-info pull-right">Seçilen Doktoru Listeye Ekle</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                        </div>
                    </div>
                </div>
            </div>
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
