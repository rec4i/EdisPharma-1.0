<%@ Page Title="" Language="C#" MasterPageFile="~/Bs.Master" AutoEventWireup="true" CodeBehind="Kullanıcı-Olustur.aspx.cs" Inherits="deneme9.Kullanıcı_Olustur" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                 
                    <div class="row">
                        <div class="col-xs-12 col-xs-6">
                               <label>Soyad</label>
                            <div class="form-group">
                               <input class="form-control" type="number" id="Kullanıcı_Ad" />
                            </div>
                        </div>
                        <div class="col-xs-12 col-xs-6">
                                <label>Ad</label>
                            <div class="form-group">
                                <input class="form-control" type="number" id="Kullanıcı_Soyad" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-xs-4">
                               <label>Kullancı Adı</label>
                            <div class="form-group">
                               <input class="form-control" type="input" id="Kullanıcı_Giriş_Adı" />
                            </div>
                        </div>
                        <div class="col-xs-12 col-xs-4">
                                <label>Şifre</label>
                            <div class="form-group">
                                <input class="form-control" type="password" id="Kullanıcı_Şifre" />
                            </div>
                        </div>
                         <div class="col-xs-12 col-xs-4">
                                <label>Şifre Yeniden</label>
                            <div class="form-group">
                                <input class="form-control" type="password" id="Kullanıcı_Şifre_Yeniden" />
                            </div>
                        </div>
                    </div>

                      <div class="row">
                        <div class="col-xs-12 col-xs-6 ">
                               <label>Kullancı Tipi</label>
                            <div class="form-group">
                               <input class="form-control" type="input" id="Kullanıcı_Tipi" />
                            </div>
                        </div>
                        <div class="col-xs-12 col-xs-6">
                                <label>Kullanıcı Bölgesi</label>
                            <div class="form-group">
                                <input class="form-control" type="password" id="Kullanıcı_Bölgesi" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-xs-6">
                                <label>Araç</label>
                            <div class="form-group">
                                     <select class="form-control" id="Kullanıcı_Araç" disabled></select>
                            </div>
                        </div>
                         <div class="col-xs-12 col-xs-6">
                                <label>İşe Baş. Tar.</label>
                            <div class="form-group">
                                <input class="form-control" type="date" id="Kullanıcı_İse_Bas_Tar" />
                            </div>
                        </div>
                    </div>












                </div>
                <div class="box-footer">
                    <div class="row">
                        <div class="col-xs-12">
                        <button type="button" id="Kota_Olustur_Gönder" class="btn btn-primary pull-right">Kullanıcı Oluştur</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
