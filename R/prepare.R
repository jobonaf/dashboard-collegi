library(rgdal)
readOGR("COLLEGI_ELETTORALI_2017.shp")->ce
ced <- ce@data %>% transmute(Regione=REGIONE,
                             Provincia=PROVINCIA,
                             CittaMetropolitana=CITTAMETRO,
                             Comune=COMUNE17,
                             Popolazione=POP_2011,
                             Circoscrizione=CIRCO17_D,
                             CameraUninominale=CAM17U_NOM,
                             CameraProporzionale=CAM17P_DEN,
                             SenatoUninominale=SEN17U_NOM,
                             SenatoProporzionale=SEN17P_DEN) %>%
  group_by(Regione,Provincia,CittaMetropolitana,Comune,Circoscrizione,
           CameraUninominale,CameraProporzionale,SenatoUninominale,SenatoProporzionale) %>%
  summarise(Popolazione=sum(Popolazione)) %>%
  ungroup()
save(ced,file = "dati_collegi_elettorali_2017.rda")


