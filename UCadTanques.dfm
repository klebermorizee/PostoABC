object CadastroTanquesForm: TCadastroTanquesForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro Tanques'
  ClientHeight = 467
  ClientWidth = 735
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object TanquesPanel: TPanel
    Left = 0
    Top = 0
    Width = 735
    Height = 153
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 59
      Width = 109
      Height = 15
      Caption = 'Tipo de Combustivel'
    end
    object CodTanqueLabeledEdit: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 23
      Alignment = taRightJustify
      EditLabel.Width = 80
      EditLabel.Height = 15
      EditLabel.Caption = 'C'#243'digo Tanque'
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object DescricaoLabeledEdit: TLabeledEdit
      Left = 168
      Top = 32
      Width = 529
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 51
      EditLabel.Height = 15
      EditLabel.Caption = 'Descri'#231#227'o'
      TabOrder = 1
      Text = ''
    end
    object TipoComboBox: TComboBox
      Left = 16
      Top = 80
      Width = 121
      Height = 23
      TabOrder = 2
      Text = 'Gasolina'
      Items.Strings = (
        'Gasolina'
        'Diesel'
        'Etanol')
    end
    object CapacidadeLabeledEdit: TLabeledEdit
      Left = 168
      Top = 80
      Width = 116
      Height = 23
      Alignment = taRightJustify
      EditLabel.Width = 94
      EditLabel.Height = 15
      EditLabel.Caption = 'Capacidade Litros'
      ImeName = 'LabeledEdit'
      TabOrder = 3
      Text = ''
      OnKeyPress = CapacidadeLabeledEditKeyPress
    end
    object TotalLitrosLabeledEdit: TLabeledEdit
      Left = 320
      Top = 80
      Width = 121
      Height = 23
      Alignment = taRightJustify
      EditLabel.Width = 73
      EditLabel.Height = 15
      EditLabel.Caption = 'Total de Litros'
      TabOrder = 4
      Text = ''
      OnKeyPress = TotalLitrosLabeledEditKeyPress
    end
    object SalvarButton: TButton
      Left = 541
      Top = 123
      Width = 75
      Height = 25
      Caption = '&Salvar'
      TabOrder = 5
      OnClick = SalvarButtonClick
    end
    object DeletarButton: TButton
      Left = 622
      Top = 122
      Width = 75
      Height = 25
      Caption = '&Deletar'
      TabOrder = 6
      OnClick = DeletarButtonClick
    end
    object IncluirButton: TButton
      Left = 460
      Top = 122
      Width = 75
      Height = 25
      Caption = '&Incluir'
      TabOrder = 7
      OnClick = IncluirButtonClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 735
    Height = 312
    Align = alCustom
    TabOrder = 1
    object TanquesDBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 734
      Height = 312
      Align = alCustom
      DataSource = TanquesDataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = TanquesDBGridDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_TANQUE'
          Title.Caption = 'C'#243'digo'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 285
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO'
          Title.Caption = 'Tipo'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAPACIDADE_LITROS'
          Title.Caption = 'Capacidade'
          Width = 108
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTAL_LITROS'
          Title.Caption = 'Total de Litros'
          Width = 119
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DATA_INCLUSAO'
          Title.Caption = 'Data de Inclus'#227'o'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DATA_ATUALIZACAO'
          Title.Caption = 'Data de Atualiza'#231#227'o'
          Visible = True
        end>
    end
  end
  object TanquesFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      
        'SELECT COD_TANQUE,DESCRICAO,TIPO,CAPACIDADE_LITROS,TOTAL_LITROS,' +
        'DATA_ATUALIZACAO,DATA_INCLUSAO FROM TANQUES')
    Left = 296
    Top = 104
    object TanquesFDQueryCOD_TANQUE: TIntegerField
      FieldName = 'COD_TANQUE'
      Origin = 'TOTAL_LITROS'
      Required = True
    end
    object TanquesFDQueryDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 150
    end
    object TanquesFDQueryCAPACIDADE_LITROS: TFMTBCDField
      FieldName = 'CAPACIDADE_LITROS'
      Origin = 'CAPACIDADE_LITROS'
      DisplayFormat = '###0.000'
      Precision = 18
      Size = 3
    end
    object TanquesFDQueryTOTAL_LITROS: TFMTBCDField
      FieldName = 'TOTAL_LITROS'
      Origin = 'TOTAL_LITROS'
      DisplayFormat = '###0.000'
      Precision = 18
      Size = 3
    end
    object TanquesFDQueryTIPO: TStringField
      FieldName = 'TIPO'
    end
    object TanquesFDQueryDATA_ATUALIZACAO: TDateField
      FieldName = 'DATA_ATUALIZACAO'
      Origin = 'DATA_ATUALIZACAO'
    end
    object TanquesFDQueryDATA_INCLUSAO: TDateField
      FieldName = 'DATA_INCLUSAO'
      Origin = 'DATA_INCLUSAO'
    end
  end
  object TanquesDataSource: TDataSource
    DataSet = TanquesFDQuery
    Left = 384
    Top = 104
  end
  object CodigoFDQuery: TFDQuery
    Connection = FrmPrincipal.FDConnection
    SQL.Strings = (
      
        'SELECT COD_TANQUE,DESCRICAO,TIPO,CAPACIDADE_LITROS,TOTAL_LITROS ' +
        'FROM TANQUES')
    Left = 192
    Top = 104
    object LargeintField1: TLargeintField
      FieldName = 'COD_TANQUE'
    end
  end
end
