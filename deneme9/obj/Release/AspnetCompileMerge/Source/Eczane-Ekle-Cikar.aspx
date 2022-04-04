<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Eczane-Ekle-Cikar.aspx.cs" Inherits="deneme9.Eczane_Ekle_Cikar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            var Eczane_Ekle_Çıkar_Ekle_il = $('select[id=Eczane_Ekle_Çıkar_Ekle_il]')//Eczane_Ekle_Çıkar_Ekle_Brick
            var Eczane_Ekle_Çıkar_Ekle_Brick = $('select[id=Eczane_Ekle_Çıkar_Ekle_Brick]')//Eczane_Ekle_Çıkar_Ekle_Ad//Eczane_Ekle_Çıkar_Ekle_Button//Eczane_Ekle_Çıkar_Ekle_Telefon
            var Eczane_Ekle_Çıkar_Ekle_Ad = $('input[id=Eczane_Ekle_Çıkar_Ekle_Ad]')
            var Eczane_Ekle_Çıkar_Ekle_Button = $('a[id=Eczane_Ekle_Çıkar_Ekle_Button]')//Eczane_Ekle_Çıkar_Çıkar_Adres//Eczane_Ekle_Çıkar_Çıkar_Adres//Eczane_Ekle_Çıkar_Çıkar_Eczaneler//Eczane_Ekle_Çıkar_Çıkar_Brick
            var Eczane_Ekle_Çıkar_Ekle_Telefon = $('input[id=Eczane_Ekle_Çıkar_Ekle_Telefon]')//Eczane_Ekle_Çıkar_Çıkar_Il
            var Eczane_Ekle_Çıkar_Ekle_Adres = $('textarea[id=Eczane_Ekle_Çıkar_Ekle_Adres]')//Eczane_Ekle_Çıkar_Duzenle_Button



            var Eczane_Ekle_Çıkar_Çıkar_Il = $('select[id=Eczane_Ekle_Çıkar_Çıkar_Il]')//Eczane_Ekle_Çıkar_Çıkar_Button
            var Eczane_Ekle_Çıkar_Çıkar_Adres = $('textarea[id=Eczane_Ekle_Çıkar_Çıkar_Adres]')
            var Eczane_Ekle_Çıkar_Çıkar_Eczaneler = $('select[id=Eczane_Ekle_Çıkar_Çıkar_Eczaneler]')
            var Eczane_Ekle_Çıkar_Çıkar_Brick = $('select[id=Eczane_Ekle_Çıkar_Çıkar_Brick]')
            var Eczane_Ekle_Çıkar_Çıkar_Telefon = $('input[id=Eczane_Ekle_Çıkar_Çıkar_Telefon]')
            var Eczane_Ekle_Çıkar_Çıkar_Button = $('a[id=Eczane_Ekle_Çıkar_Çıkar_Button]')
            var Eczane_Ekle_Çıkar_Çıkar_Eczane_Konumu = $('select[id=Eczane_Ekle_Çıkar_Çıkar_Eczane_Konumu]')

            $.ajax({
                url: 'Eczane-Ekle-Cikar.aspx/Eczane_Tip',
                dataType: 'json',
                type: 'POST',
                data: "{'Liste_Adı': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Eczane_Ekle_Çıkar_Çıkar_Eczane_Konumu.empty();
                    Eczane_Ekle_Çıkar_Çıkar_Eczane_Konumu.append("<option value='0'>-->> Lütfen Konum Tipi Seçiniz <<--</option>")
                    var temp = JSON.parse(data.d)
                    for (var i = 0; i < temp.length; i++) {
                        Eczane_Ekle_Çıkar_Çıkar_Eczane_Konumu.append("<option value='" + temp[i].Eczane_Tip_Id +"'>" + temp[i].Eczane_Tip_Text+"</option>")
                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            $.ajax({
                url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Eczane_Ekle_Çıkar_Çıkar_Il.empty();
                    Eczane_Ekle_Çıkar_Çıkar_Il.append("<option value='0'>-->> Lütfen Şehir Seçiniz <<--</option>")
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Eczane_Ekle_Çıkar_Çıkar_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Eczane_Ekle_Çıkar_Çıkar_Il.change(function () {
                Eczane_Ekle_Çıkar_Çıkar_Il.parent().removeAttr("class");
                Eczane_Ekle_Çıkar_Çıkar_Il.parent().attr("class", "form-group");
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Çıkar_Brick.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Brick.append("<option value='0'>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Çıkar_Çıkar_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Eczane_Ekle_Çıkar_Çıkar_Il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Çıkar_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
                // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            })


            Eczane_Ekle_Çıkar_Çıkar_Brick.change(function () {


                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/Eczane_Listele',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).val() + "-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Çıkar_Adres.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Telefon.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Eczaneler.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Eczaneler.append("<option value='0'>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Çıkar_Çıkar_Eczaneler.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                         
                            b++;
                        }
                        if (Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });
            Eczane_Ekle_Çıkar_Çıkar_Eczaneler.change(function () {

                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/Eczane_Listele_detay',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Eczane_Id': '" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var Eczane_Ekle_Çıkar_Çıkar_Eczane_Tip = $('input[id=Eczane_Ekle_Çıkar_Çıkar_Eczane_Tip]')
                        Eczane_Ekle_Çıkar_Çıkar_Eczane_Tip.empty()
                        Eczane_Ekle_Çıkar_Çıkar_Adres.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Telefon.empty();

                        var temp=JSON.parse(data.d)
                        for (var i = 0; i < temp.length; i++) {
                            Eczane_Ekle_Çıkar_Çıkar_Adres.val(temp[i].Eczane_Adres)
                            Eczane_Ekle_Çıkar_Çıkar_Telefon.val(temp[i].Eczane_Telefon)
                            Eczane_Ekle_Çıkar_Çıkar_Eczane_Tip.val(temp[i].Eczane_Tip)
                        }
                        
                      
                        if (Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });//Eczane_Çıkar_Button


            });
            Eczane_Ekle_Çıkar_Çıkar_Button.click(function () {

                var Gönderilsinmi_ = true;
                var Kapansınmı = 0;
                $('select[name*=input_Çıkar]').each(function () {

                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi_ = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });



                if (Gönderilsinmi_ == true) {
                    $.ajax({
                        url: 'Eczane-Ekle-Cikar.aspx/Eczane_Çıkar_Button',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + Eczane_Ekle_Çıkar_Çıkar_Eczaneler.find('option:selected').val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            Eczane_Ekle_Çıkar_Çıkar_Adres.val("");
                            Eczane_Ekle_Çıkar_Çıkar_Telefon.val("");
                            Eczane_Ekle_Çıkar_Çıkar_Eczaneler.val("");
                            Eczane_Ekle_Çıkar_Çıkar_Brick.val("");
                            if (data.d == "1") {
                                alert("İşlem Başarılı")
                            }
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });//Eczane_Çıkar_Button
                }


              

            });

            var Eczane_Ekle_Cıkar_Duzenle_İl = $('select[id=Eczane_Ekle_Cıkar_Duzenle_İl]')
            var Eczane_Ekle_Cıkar_Duzenle_Brick = $('select[id=Eczane_Ekle_Cıkar_Duzenle_Brick]')
            var Eczane_Ekle_Cıkar_Duzenle_Eczane = $('select[id=Eczane_Ekle_Cıkar_Duzenle_Eczane]')
            $.ajax({
                url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Eczane_Ekle_Cıkar_Duzenle_İl.empty();
                    Eczane_Ekle_Cıkar_Duzenle_İl.append("<option value='0'>-->> Lütfen Şehir Seçiniz <<--</option>")
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Eczane_Ekle_Cıkar_Duzenle_İl.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Eczane_Ekle_Cıkar_Duzenle_İl.change(function () {
                Eczane_Ekle_Çıkar_Çıkar_Il.parent().removeAttr("class");
                Eczane_Ekle_Çıkar_Çıkar_Il.parent().attr("class", "form-group");
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Cıkar_Duzenle_Brick.empty();
                        Eczane_Ekle_Cıkar_Duzenle_Brick.append("<option value='0'>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Cıkar_Duzenle_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Eczane_Ekle_Cıkar_Duzenle_İl.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Cıkar_Duzenle_İl.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
                // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            })


            Eczane_Ekle_Cıkar_Duzenle_Brick.change(function () {


                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/Eczane_Listele',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).val() + "-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                      
                        Eczane_Ekle_Cıkar_Duzenle_Eczane.empty();
                        Eczane_Ekle_Cıkar_Duzenle_Eczane.append("<option value='0'>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Cıkar_Duzenle_Eczane.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");

                            b++;
                        }
                        if (Eczane_Ekle_Cıkar_Duzenle_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Cıkar_Duzenle_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });
            var Eczane_Ekle_Çıkar_Duzenle_Button = $('a[id=Eczane_Ekle_Çıkar_Duzenle_Button]')
            Eczane_Ekle_Cıkar_Duzenle_Eczane.change(function () {

                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Bilgisi_Getir',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'Eczane_Id': '" + $(this).find('option:selected').val() + " '}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var temp = JSON.parse(data.d)
                       
                        $('input[id=Eczane_Ekle_Cıkar_Duzenle_Eczane_Tip]').val(temp[0].Eczane_Tip)

                        $('input[id=Eczane_Ekle_Cıkar_Duzenle_Telefon]').val(temp[0].Eczane_Telefon)

                        $('textarea[id=Eczane_Ekle_Cıkar_Duzenle_Adres]').val(temp[0].Eczane_Adres)

                        $('input[id=Eczane_Ekle_Cıkar_Duzenle_Eposta]').val(temp[0].Eposta)

                        $('input[id=Eczane_Ekle_Cıkar_Duzenle_Gln_No]').val(temp[0].Gln_No)
                        Eczane_Ekle_Çıkar_Duzenle_Button.attr("Eczane_Id", temp[0].Eczane_Id)

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        //doktorları listelerken tersten listele 
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
                

            });

       



            Eczane_Ekle_Çıkar_Duzenle_Button.click(function () {//Zamanlı_Giriş_Deneme
                var Gönderilsinmi = true;
                var Kapansınmı = 0;
                $('select[name*=Select_Duzenle]').each(function () {
                    console.log($(this).val())
                    if ($(this).find('option:selected').val() == "0" || $(this).find('option:selected').val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                        
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });
                
                console.log(Gönderilsinmi)
                if (Gönderilsinmi == true) {
                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Bilgisi_Getir',
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Eczane_Id': '" + $(this).attr('Eczane_Id') + " '}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var temp = JSON.parse(data.d)

                            $('a[id=Eczane_Duzenle]').attr("Eczane_id", temp[0].Eczane_Id)

                            $('input[id=Default_Il]').val(temp[0].Eczane_İl)
                      


                            $('input[id=Default_Brick]').val(temp[0].Eczane_Brick)
                           




                            $('input[id=Default_Ad]').val(temp[0].Eczane_Adı)
                       

                            $('input[id=Default_Tel]').val(temp[0].Eczane_Telefon)
                           

                            $('input[id=Default_Adres]').val(temp[0].Eczane_Adres)
                           

                            $('input[id=Default_Eposta]').val(temp[0].Eposta)
                        

                            $('input[id=Default_Gln]').val(temp[0].Gln_No)
                         


                            $('#Eczane_Eksik_Bilgi').modal('show')

                        },
                        error: function () {
                            //doktorları listelerken tersten listele 
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                    
                }
            

            });
            var Düzenle_İl = $('select[id=Düzenle_İl]')
            var Düzenle_Brick = $('select[id=Düzenle_Brick]')
            $.ajax({
                url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Düzenle_İl.empty();
                    Düzenle_İl.append("<option value='0'>-->> Lütfen Şehir Seçiniz <<--</option>")
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Düzenle_İl.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Düzenle_İl.change(function () {
               
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Düzenle_Brick.empty();
                        Düzenle_Brick.append("<option value='0'>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Düzenle_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Düzenle_İl.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Düzenle_İl.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
                // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            })



            var Eczane_Duzenle = $('a[id=Eczane_Duzenle]')




            Eczane_Duzenle.click(function () {

                var Gönderilsinmi = true;
                var Kapansınmı = 0;
                $('select[name*=Duzenle_Modal_Select]').each(function () {

                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });
                $('[name*=Duzenle_Modal_İnput]').each(function () {

                    if ($(this).val() == "" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });
                if (Gönderilsinmi==true) {
                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Eczane_Düzenle_Talep_Gonder',
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
                            var temp = JSON.parse(data.d)
                            console.log(data.d)
                            if (temp[0].Sonuç == "") {
                                alert("İşlem Başarı İle iletildi")
                            }
                            if (temp[0].Sonuç == "1") {
                                alert("Zaten Talep Oluşturulmuş")
                            }
                            $('#Eczane_Eksik_Bilgi').modal('toggle')

                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {
                            //doktorları listelerken tersten listele 
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
                    
                

            })














            function Il_Listele() {
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '0-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Ekle_il.empty();
                        Eczane_Ekle_Çıkar_Ekle_il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Eczane_Ekle_Çıkar_Ekle_il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

                        }

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            }
            $.ajax({
                url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Eczane_Ekle_Çıkar_Ekle_il.empty();
                    Eczane_Ekle_Çıkar_Ekle_il.append("<option value='0'>-->> Lütfen Şehir Seçiniz <<--</option>")
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Eczane_Ekle_Çıkar_Ekle_il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Eczane_Ekle_Çıkar_Ekle_il.change(function () {
                Eczane_Ekle_Çıkar_Ekle_il.parent().removeAttr("class");
                Eczane_Ekle_Çıkar_Ekle_il.parent().attr("class", "form-group");
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Ekle_Brick.empty();
                        Eczane_Ekle_Çıkar_Ekle_Brick.append("<option value='0'>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Çıkar_Ekle_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Eczane_Ekle_Çıkar_Ekle_il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Ekle_il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
                // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            })

            Eczane_Ekle_Çıkar_Ekle_Button.click(function () {
                var Gönderilsinmi = true;
                var Kapansınmı = 0;
                $('select[name*=Select_Ekle]').each(function () {

                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });
                $('[name*=input_Ekle]').each(function () {

                    if ($(this).val() == "" || $(this).val() == null) {
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
                        url: 'Eczane-Ekle-Cikar.aspx/Eczane_Ekle',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + + "-" +  + "-" +  + "-" +  + "-" +  + "'}",
                        data: "{'':''," +
                            "'ad':'" + $('input[id=Eczane_Ekle_Çıkar_Ekle_Ad]').val() + "'," +
                            "'Brick':'" + Eczane_Ekle_Çıkar_Ekle_Brick.val()+ "'," +
                            "'Il':'" + Eczane_Ekle_Çıkar_Ekle_il.val()+"'," +
                            "'Adres':'" + Eczane_Ekle_Çıkar_Ekle_Adres.val()+"'," +
                            "'Telefon':'" + Eczane_Ekle_Çıkar_Ekle_Telefon.val() + "'," +
                            "'Eczane_Tip':'" + Eczane_Ekle_Çıkar_Çıkar_Eczane_Konumu.val() + "'}",


                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            $('[name*=input_Ekle]').each(function () {
                                $(this).val("")
                            });

                            var Doktor_Ekle_İşlem_Sonucu = $('p[id*=Doktor_Ekle_İşlem_Sonucu]');
                            Doktor_Ekle_İşlem_Sonucu.empty();
                            Doktor_Ekle_İşlem_Sonucu.append("İşlem Başarıyla DataBase'e İşlendi")
                            $('#Doktor_Ekle_Modal').modal('toggle');
                        

                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }

                

            });



        });


    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                                    <select name="Duzenle_Modal_Select" id="Düzenle_İl" class="form-control" ></select>
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
                                    <select  name="Duzenle_Modal_Select"  id="Düzenle_Brick" class="form-control" ></select>
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
                                    <input name="Duzenle_Modal_İnput" id="Düzenle_Ad" type="text" class="form-control" />
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
                                <div class="form-group">
                                    <select   id="Default_Eczane_Tip" class="form-control" disabled>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select  name="Duzenle_Modal_Select"  id="Eczane_Tip" class="form-control">
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
                                 <input name="Ekle_İnput" id="Default_Tel" type="text" class="form-control" disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input  name="Duzenle_Modal_İnput"  id="Düzenle_Tel" type="text" class="form-control" ></input>
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
                                 <input name="Ekle_İnput" id="Default_Adres" type="text" class="form-control" disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Duzenle_Modal_İnput" id="Düzenle_Adres"  type="text" class="form-control" ></input>
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
                                 <input name="Ekle_İnput" id="Default_Eposta" type="text" class="form-control" disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Duzenle_Modal_İnput"  id="Düzenle_Eposta"  type="text" class="form-control" ></input>
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
                                 <input name="Ekle_İnput" id="Default_Gln" type="text" class="form-control" disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input  name="Duzenle_Modal_İnput" id="Düzenle_Gln"  type="text" class="form-control" ></input>
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
    <div id="Doktor_Ekle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">İşlem Sonucu</h4>
                </div>
                <div class="modal-body">
                    <p id="Doktor_Ekle_İşlem_Sonucu"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                </div>
            </div>

        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tab_1" data-toggle="tab" aria-expanded="true">Eczane Düzenle
                        </a>
                    </li>
                    <li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="false">Eczane Çıkar</a></li>
                    <li class=""><a href="#tab_3" data-toggle="tab" aria-expanded="false">Eczane Ekle</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab_1">


                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="Select_Duzenle" id="Eczane_Ekle_Cıkar_Duzenle_İl" class="form-control"></select>
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
                                    <select name="Select_Duzenle" id="Eczane_Ekle_Cıkar_Duzenle_Brick" class="form-control"></select>
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
                                    <select name="Select_Duzenle" id="Eczane_Ekle_Cıkar_Duzenle_Eczane" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-xs-12">
                                <label>Eczane Tip</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Eczane_Ekle_Cıkar_Duzenle_Eczane_Tip"  type="text" class="form-control" disabled>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Telefon</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Eczane_Ekle_Cıkar_Duzenle_Telefon" type="text" class="form-control" disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Adres</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <textarea  id="Eczane_Ekle_Cıkar_Duzenle_Adres" class="form-control" rows="3" disabled></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label>Eposta</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input  id="Eczane_Ekle_Cıkar_Duzenle_Eposta" type="text" class="form-control" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label>Gln No</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input  id="Eczane_Ekle_Cıkar_Duzenle_Gln_No" type="text" class="form-control" disabled>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Eczane_Ekle_Çıkar_Duzenle_Button" class="btn btn-info pull-right">Seçilen Eczaneyi Düzenle</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab_2">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="input_Çıkar" id="Eczane_Ekle_Çıkar_Çıkar_Il" class="form-control"></select>
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
                                    <select name="input_Çıkar" id="Eczane_Ekle_Çıkar_Çıkar_Brick" class="form-control"></select>
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
                                    <select name="input_Çıkar" id="Eczane_Ekle_Çıkar_Çıkar_Eczaneler" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Eczane Konum Tipi</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                     <input id="Eczane_Ekle_Çıkar_Çıkar_Eczane_Tip" type="text" class="form-control" disabled="">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Telefon</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Eczane_Ekle_Çıkar_Çıkar_Telefon" type="text" class="form-control" disabled="">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Adres</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <textarea id="Eczane_Ekle_Çıkar_Çıkar_Adres" class="form-control" rows="3" disabled=""></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Eczane_Ekle_Çıkar_Çıkar_Button" class="btn btn-info pull-right">Seçilen Eczaneyi Çıkar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab_3">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="Select_Ekle" id="Eczane_Ekle_Çıkar_Ekle_il" class="form-control"></select>
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
                                    <select name="Select_Ekle" id="Eczane_Ekle_Çıkar_Ekle_Brick" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Konumu Seçiniz </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="Select_Ekle" id="Eczane_Ekle_Çıkar_Çıkar_Eczane_Konumu" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Adı Giriniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="input_Ekle" id="Eczane_Ekle_Çıkar_Ekle_Ad" type="text" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Telefon</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="input_Ekle" id="Eczane_Ekle_Çıkar_Ekle_Telefon" type="text" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Adres</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <textarea name="input_Ekle" id="Eczane_Ekle_Çıkar_Ekle_Adres" class="form-control" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Eczane_Ekle_Çıkar_Ekle_Button" class="btn btn-info pull-right">Eczaneyi Ekle</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

