import XCTest
@testable import SBFoundation

final class TimeZoneExtensionsTests: XCTestCase {
    
    func testKnownTimeZoneIdentifiersCount() {
        // Test time zones
        XCTAssertEqual(TimeZone.staticTimeZones.count, TimeZone.knownTimeZoneIdentifiers.count)
        guard TimeZone.staticTimeZones.count == TimeZone.knownTimeZoneIdentifiers.count else {
            print(TimeZone.staticTimeZones.joined(separator: "\n\n"))
            return
        }
        // Test time zone tests
        XCTAssertEqual(TimeZone.staticTimeZoneTests.count, TimeZone.knownTimeZoneIdentifiers.count)
        guard TimeZone.staticTimeZoneTests.count == TimeZone.knownTimeZoneIdentifiers.count else {
            print(TimeZone.staticTimeZoneTests.joined(separator: "\n\n"))
            return
        }
        // Test time zone all cases
        XCTAssertEqual(TimeZone.knownTimeZoneIdentifiers.count, TimeZone.allCases.count)
        guard TimeZone.knownTimeZoneIdentifiers.count == TimeZone.allCases.count else {
            print(TimeZone.allCasesBuilder.joined(separator: "\n"))
            return
        }
    }
    
    func testTimeZoneIdentifiers() {

        XCTAssertEqual(TimeZone.africaAbidjan.identifier, "Africa/Abidjan")

        XCTAssertEqual(TimeZone.africaAccra.identifier, "Africa/Accra")

        XCTAssertEqual(TimeZone.africaAddisAbaba.identifier, "Africa/Addis_Ababa")

        XCTAssertEqual(TimeZone.africaAlgiers.identifier, "Africa/Algiers")

        XCTAssertEqual(TimeZone.africaAsmara.identifier, "Africa/Asmara")

        XCTAssertEqual(TimeZone.africaBamako.identifier, "Africa/Bamako")

        XCTAssertEqual(TimeZone.africaBangui.identifier, "Africa/Bangui")

        XCTAssertEqual(TimeZone.africaBanjul.identifier, "Africa/Banjul")

        XCTAssertEqual(TimeZone.africaBissau.identifier, "Africa/Bissau")

        XCTAssertEqual(TimeZone.africaBlantyre.identifier, "Africa/Blantyre")

        XCTAssertEqual(TimeZone.africaBrazzaville.identifier, "Africa/Brazzaville")

        XCTAssertEqual(TimeZone.africaBujumbura.identifier, "Africa/Bujumbura")

        XCTAssertEqual(TimeZone.africaCairo.identifier, "Africa/Cairo")

        XCTAssertEqual(TimeZone.africaCasablanca.identifier, "Africa/Casablanca")

        XCTAssertEqual(TimeZone.africaCeuta.identifier, "Africa/Ceuta")

        XCTAssertEqual(TimeZone.africaConakry.identifier, "Africa/Conakry")

        XCTAssertEqual(TimeZone.africaDakar.identifier, "Africa/Dakar")

        XCTAssertEqual(TimeZone.africaDarEsSalaam.identifier, "Africa/Dar_es_Salaam")

        XCTAssertEqual(TimeZone.africaDjibouti.identifier, "Africa/Djibouti")

        XCTAssertEqual(TimeZone.africaDouala.identifier, "Africa/Douala")

        XCTAssertEqual(TimeZone.africaElAaiun.identifier, "Africa/El_Aaiun")

        XCTAssertEqual(TimeZone.africaFreetown.identifier, "Africa/Freetown")

        XCTAssertEqual(TimeZone.africaGaborone.identifier, "Africa/Gaborone")

        XCTAssertEqual(TimeZone.africaHarare.identifier, "Africa/Harare")

        XCTAssertEqual(TimeZone.africaJohannesburg.identifier, "Africa/Johannesburg")

        XCTAssertEqual(TimeZone.africaJuba.identifier, "Africa/Juba")

        XCTAssertEqual(TimeZone.africaKampala.identifier, "Africa/Kampala")

        XCTAssertEqual(TimeZone.africaKhartoum.identifier, "Africa/Khartoum")

        XCTAssertEqual(TimeZone.africaKigali.identifier, "Africa/Kigali")

        XCTAssertEqual(TimeZone.africaKinshasa.identifier, "Africa/Kinshasa")

        XCTAssertEqual(TimeZone.africaLagos.identifier, "Africa/Lagos")

        XCTAssertEqual(TimeZone.africaLibreville.identifier, "Africa/Libreville")

        XCTAssertEqual(TimeZone.africaLome.identifier, "Africa/Lome")

        XCTAssertEqual(TimeZone.africaLuanda.identifier, "Africa/Luanda")

        XCTAssertEqual(TimeZone.africaLubumbashi.identifier, "Africa/Lubumbashi")

        XCTAssertEqual(TimeZone.africaLusaka.identifier, "Africa/Lusaka")

        XCTAssertEqual(TimeZone.africaMalabo.identifier, "Africa/Malabo")

        XCTAssertEqual(TimeZone.africaMaputo.identifier, "Africa/Maputo")

        XCTAssertEqual(TimeZone.africaMaseru.identifier, "Africa/Maseru")

        XCTAssertEqual(TimeZone.africaMbabane.identifier, "Africa/Mbabane")

        XCTAssertEqual(TimeZone.africaMogadishu.identifier, "Africa/Mogadishu")

        XCTAssertEqual(TimeZone.africaMonrovia.identifier, "Africa/Monrovia")

        XCTAssertEqual(TimeZone.africaNairobi.identifier, "Africa/Nairobi")

        XCTAssertEqual(TimeZone.africaNdjamena.identifier, "Africa/Ndjamena")

        XCTAssertEqual(TimeZone.africaNiamey.identifier, "Africa/Niamey")

        XCTAssertEqual(TimeZone.africaNouakchott.identifier, "Africa/Nouakchott")

        XCTAssertEqual(TimeZone.africaOuagadougou.identifier, "Africa/Ouagadougou")

        XCTAssertEqual(TimeZone.africaPortoNovo.identifier, "Africa/Porto-Novo")

        XCTAssertEqual(TimeZone.africaSaoTome.identifier, "Africa/Sao_Tome")

        XCTAssertEqual(TimeZone.africaTripoli.identifier, "Africa/Tripoli")

        XCTAssertEqual(TimeZone.africaTunis.identifier, "Africa/Tunis")

        XCTAssertEqual(TimeZone.africaWindhoek.identifier, "Africa/Windhoek")

        XCTAssertEqual(TimeZone.americaAdak.identifier, "America/Adak")

        XCTAssertEqual(TimeZone.americaAnchorage.identifier, "America/Anchorage")

        XCTAssertEqual(TimeZone.americaAnguilla.identifier, "America/Anguilla")

        XCTAssertEqual(TimeZone.americaAntigua.identifier, "America/Antigua")

        XCTAssertEqual(TimeZone.americaAraguaina.identifier, "America/Araguaina")

        XCTAssertEqual(TimeZone.americaArgentinaBuenosAires.identifier, "America/Argentina/Buenos_Aires")

        XCTAssertEqual(TimeZone.americaArgentinaCatamarca.identifier, "America/Argentina/Catamarca")

        XCTAssertEqual(TimeZone.americaArgentinaCordoba.identifier, "America/Argentina/Cordoba")

        XCTAssertEqual(TimeZone.americaArgentinaJujuy.identifier, "America/Argentina/Jujuy")

        XCTAssertEqual(TimeZone.americaArgentinaLaRioja.identifier, "America/Argentina/La_Rioja")

        XCTAssertEqual(TimeZone.americaArgentinaMendoza.identifier, "America/Argentina/Mendoza")

        XCTAssertEqual(TimeZone.americaArgentinaRioGallegos.identifier, "America/Argentina/Rio_Gallegos")

        XCTAssertEqual(TimeZone.americaArgentinaSalta.identifier, "America/Argentina/Salta")

        XCTAssertEqual(TimeZone.americaArgentinaSanJuan.identifier, "America/Argentina/San_Juan")

        XCTAssertEqual(TimeZone.americaArgentinaSanLuis.identifier, "America/Argentina/San_Luis")

        XCTAssertEqual(TimeZone.americaArgentinaTucuman.identifier, "America/Argentina/Tucuman")

        XCTAssertEqual(TimeZone.americaArgentinaUshuaia.identifier, "America/Argentina/Ushuaia")

        XCTAssertEqual(TimeZone.americaAruba.identifier, "America/Aruba")

        XCTAssertEqual(TimeZone.americaAsuncion.identifier, "America/Asuncion")

        XCTAssertEqual(TimeZone.americaAtikokan.identifier, "America/Atikokan")

        XCTAssertEqual(TimeZone.americaBahia.identifier, "America/Bahia")

        XCTAssertEqual(TimeZone.americaBahiaBanderas.identifier, "America/Bahia_Banderas")

        XCTAssertEqual(TimeZone.americaBarbados.identifier, "America/Barbados")

        XCTAssertEqual(TimeZone.americaBelem.identifier, "America/Belem")

        XCTAssertEqual(TimeZone.americaBelize.identifier, "America/Belize")

        XCTAssertEqual(TimeZone.americaBlancSablon.identifier, "America/Blanc-Sablon")

        XCTAssertEqual(TimeZone.americaBoaVista.identifier, "America/Boa_Vista")

        XCTAssertEqual(TimeZone.americaBogota.identifier, "America/Bogota")

        XCTAssertEqual(TimeZone.americaBoise.identifier, "America/Boise")

        XCTAssertEqual(TimeZone.americaCambridgeBay.identifier, "America/Cambridge_Bay")

        XCTAssertEqual(TimeZone.americaCampoGrande.identifier, "America/Campo_Grande")

        XCTAssertEqual(TimeZone.americaCancun.identifier, "America/Cancun")

        XCTAssertEqual(TimeZone.americaCaracas.identifier, "America/Caracas")

        XCTAssertEqual(TimeZone.americaCayenne.identifier, "America/Cayenne")

        XCTAssertEqual(TimeZone.americaCayman.identifier, "America/Cayman")

        XCTAssertEqual(TimeZone.americaChicago.identifier, "America/Chicago")

        XCTAssertEqual(TimeZone.americaChihuahua.identifier, "America/Chihuahua")

        XCTAssertEqual(TimeZone.americaCiudadJuarez.identifier, "America/Ciudad_Juarez")

        XCTAssertEqual(TimeZone.americaCostaRica.identifier, "America/Costa_Rica")

        XCTAssertEqual(TimeZone.americaCreston.identifier, "America/Creston")

        XCTAssertEqual(TimeZone.americaCuiaba.identifier, "America/Cuiaba")

        XCTAssertEqual(TimeZone.americaCuracao.identifier, "America/Curacao")

        XCTAssertEqual(TimeZone.americaDanmarkshavn.identifier, "America/Danmarkshavn")

        XCTAssertEqual(TimeZone.americaDawson.identifier, "America/Dawson")

        XCTAssertEqual(TimeZone.americaDawsonCreek.identifier, "America/Dawson_Creek")

        XCTAssertEqual(TimeZone.americaDenver.identifier, "America/Denver")

        XCTAssertEqual(TimeZone.americaDetroit.identifier, "America/Detroit")

        XCTAssertEqual(TimeZone.americaDominica.identifier, "America/Dominica")

        XCTAssertEqual(TimeZone.americaEdmonton.identifier, "America/Edmonton")

        XCTAssertEqual(TimeZone.americaEirunepe.identifier, "America/Eirunepe")

        XCTAssertEqual(TimeZone.americaElSalvador.identifier, "America/El_Salvador")

        XCTAssertEqual(TimeZone.americaFortNelson.identifier, "America/Fort_Nelson")

        XCTAssertEqual(TimeZone.americaFortaleza.identifier, "America/Fortaleza")

        XCTAssertEqual(TimeZone.americaGlaceBay.identifier, "America/Glace_Bay")

        XCTAssertEqual(TimeZone.americaGodthab.identifier, "America/Godthab")

        XCTAssertEqual(TimeZone.americaGooseBay.identifier, "America/Goose_Bay")

        XCTAssertEqual(TimeZone.americaGrandTurk.identifier, "America/Grand_Turk")

        XCTAssertEqual(TimeZone.americaGrenada.identifier, "America/Grenada")

        XCTAssertEqual(TimeZone.americaGuadeloupe.identifier, "America/Guadeloupe")

        XCTAssertEqual(TimeZone.americaGuatemala.identifier, "America/Guatemala")

        XCTAssertEqual(TimeZone.americaGuayaquil.identifier, "America/Guayaquil")

        XCTAssertEqual(TimeZone.americaGuyana.identifier, "America/Guyana")

        XCTAssertEqual(TimeZone.americaHalifax.identifier, "America/Halifax")

        XCTAssertEqual(TimeZone.americaHavana.identifier, "America/Havana")

        XCTAssertEqual(TimeZone.americaHermosillo.identifier, "America/Hermosillo")

        XCTAssertEqual(TimeZone.americaIndianaIndianapolis.identifier, "America/Indiana/Indianapolis")

        XCTAssertEqual(TimeZone.americaIndianaKnox.identifier, "America/Indiana/Knox")

        XCTAssertEqual(TimeZone.americaIndianaMarengo.identifier, "America/Indiana/Marengo")

        XCTAssertEqual(TimeZone.americaIndianaPetersburg.identifier, "America/Indiana/Petersburg")

        XCTAssertEqual(TimeZone.americaIndianaTellCity.identifier, "America/Indiana/Tell_City")

        XCTAssertEqual(TimeZone.americaIndianaVevay.identifier, "America/Indiana/Vevay")

        XCTAssertEqual(TimeZone.americaIndianaVincennes.identifier, "America/Indiana/Vincennes")

        XCTAssertEqual(TimeZone.americaIndianaWinamac.identifier, "America/Indiana/Winamac")

        XCTAssertEqual(TimeZone.americaInuvik.identifier, "America/Inuvik")

        XCTAssertEqual(TimeZone.americaIqaluit.identifier, "America/Iqaluit")

        XCTAssertEqual(TimeZone.americaJamaica.identifier, "America/Jamaica")

        XCTAssertEqual(TimeZone.americaJuneau.identifier, "America/Juneau")

        XCTAssertEqual(TimeZone.americaKentuckyLouisville.identifier, "America/Kentucky/Louisville")

        XCTAssertEqual(TimeZone.americaKentuckyMonticello.identifier, "America/Kentucky/Monticello")

        XCTAssertEqual(TimeZone.americaKralendijk.identifier, "America/Kralendijk")

        XCTAssertEqual(TimeZone.americaLaPaz.identifier, "America/La_Paz")

        XCTAssertEqual(TimeZone.americaLima.identifier, "America/Lima")

        XCTAssertEqual(TimeZone.americaLosAngeles.identifier, "America/Los_Angeles")

        XCTAssertEqual(TimeZone.americaLowerPrinces.identifier, "America/Lower_Princes")

        XCTAssertEqual(TimeZone.americaMaceio.identifier, "America/Maceio")

        XCTAssertEqual(TimeZone.americaManagua.identifier, "America/Managua")

        XCTAssertEqual(TimeZone.americaManaus.identifier, "America/Manaus")

        XCTAssertEqual(TimeZone.americaMarigot.identifier, "America/Marigot")

        XCTAssertEqual(TimeZone.americaMartinique.identifier, "America/Martinique")

        XCTAssertEqual(TimeZone.americaMatamoros.identifier, "America/Matamoros")

        XCTAssertEqual(TimeZone.americaMazatlan.identifier, "America/Mazatlan")

        XCTAssertEqual(TimeZone.americaMenominee.identifier, "America/Menominee")

        XCTAssertEqual(TimeZone.americaMerida.identifier, "America/Merida")

        XCTAssertEqual(TimeZone.americaMetlakatla.identifier, "America/Metlakatla")

        XCTAssertEqual(TimeZone.americaMexicoCity.identifier, "America/Mexico_City")

        XCTAssertEqual(TimeZone.americaMiquelon.identifier, "America/Miquelon")

        XCTAssertEqual(TimeZone.americaMoncton.identifier, "America/Moncton")

        XCTAssertEqual(TimeZone.americaMonterrey.identifier, "America/Monterrey")

        XCTAssertEqual(TimeZone.americaMontevideo.identifier, "America/Montevideo")

        XCTAssertEqual(TimeZone.americaMontreal.identifier, "America/Montreal")

        XCTAssertEqual(TimeZone.americaMontserrat.identifier, "America/Montserrat")

        XCTAssertEqual(TimeZone.americaNassau.identifier, "America/Nassau")

        XCTAssertEqual(TimeZone.americaNewYork.identifier, "America/New_York")

        XCTAssertEqual(TimeZone.americaNipigon.identifier, "America/Nipigon")

        XCTAssertEqual(TimeZone.americaNome.identifier, "America/Nome")

        XCTAssertEqual(TimeZone.americaNoronha.identifier, "America/Noronha")

        XCTAssertEqual(TimeZone.americaNorthDakotaBeulah.identifier, "America/North_Dakota/Beulah")

        XCTAssertEqual(TimeZone.americaNorthDakotaCenter.identifier, "America/North_Dakota/Center")

        XCTAssertEqual(TimeZone.americaNorthDakotaNewSalem.identifier, "America/North_Dakota/New_Salem")

        XCTAssertEqual(TimeZone.americaNuuk.identifier, "America/Nuuk")

        XCTAssertEqual(TimeZone.americaOjinaga.identifier, "America/Ojinaga")

        XCTAssertEqual(TimeZone.americaPanama.identifier, "America/Panama")

        XCTAssertEqual(TimeZone.americaPangnirtung.identifier, "America/Pangnirtung")

        XCTAssertEqual(TimeZone.americaParamaribo.identifier, "America/Paramaribo")

        XCTAssertEqual(TimeZone.americaPhoenix.identifier, "America/Phoenix")

        XCTAssertEqual(TimeZone.americaPortAuPrince.identifier, "America/Port-au-Prince")

        XCTAssertEqual(TimeZone.americaPortOfSpain.identifier, "America/Port_of_Spain")

        XCTAssertEqual(TimeZone.americaPortoVelho.identifier, "America/Porto_Velho")

        XCTAssertEqual(TimeZone.americaPuertoRico.identifier, "America/Puerto_Rico")

        XCTAssertEqual(TimeZone.americaPuntaArenas.identifier, "America/Punta_Arenas")

        XCTAssertEqual(TimeZone.americaRainyRiver.identifier, "America/Rainy_River")

        XCTAssertEqual(TimeZone.americaRankinInlet.identifier, "America/Rankin_Inlet")

        XCTAssertEqual(TimeZone.americaRecife.identifier, "America/Recife")

        XCTAssertEqual(TimeZone.americaRegina.identifier, "America/Regina")

        XCTAssertEqual(TimeZone.americaResolute.identifier, "America/Resolute")

        XCTAssertEqual(TimeZone.americaRioBranco.identifier, "America/Rio_Branco")

        XCTAssertEqual(TimeZone.americaSantaIsabel.identifier, "America/Santa_Isabel")

        XCTAssertEqual(TimeZone.americaSantarem.identifier, "America/Santarem")

        XCTAssertEqual(TimeZone.americaSantiago.identifier, "America/Santiago")

        XCTAssertEqual(TimeZone.americaSantoDomingo.identifier, "America/Santo_Domingo")

        XCTAssertEqual(TimeZone.americaSaoPaulo.identifier, "America/Sao_Paulo")

        XCTAssertEqual(TimeZone.americaScoresbysund.identifier, "America/Scoresbysund")

        XCTAssertEqual(TimeZone.americaShiprock.identifier, "America/Shiprock")

        XCTAssertEqual(TimeZone.americaSitka.identifier, "America/Sitka")

        XCTAssertEqual(TimeZone.americaStBarthelemy.identifier, "America/St_Barthelemy")

        XCTAssertEqual(TimeZone.americaStJohns.identifier, "America/St_Johns")

        XCTAssertEqual(TimeZone.americaStKitts.identifier, "America/St_Kitts")

        XCTAssertEqual(TimeZone.americaStLucia.identifier, "America/St_Lucia")

        XCTAssertEqual(TimeZone.americaStThomas.identifier, "America/St_Thomas")

        XCTAssertEqual(TimeZone.americaStVincent.identifier, "America/St_Vincent")

        XCTAssertEqual(TimeZone.americaSwiftCurrent.identifier, "America/Swift_Current")

        XCTAssertEqual(TimeZone.americaTegucigalpa.identifier, "America/Tegucigalpa")

        XCTAssertEqual(TimeZone.americaThule.identifier, "America/Thule")

        XCTAssertEqual(TimeZone.americaThunderBay.identifier, "America/Thunder_Bay")

        XCTAssertEqual(TimeZone.americaTijuana.identifier, "America/Tijuana")

        XCTAssertEqual(TimeZone.americaToronto.identifier, "America/Toronto")

        XCTAssertEqual(TimeZone.americaTortola.identifier, "America/Tortola")

        XCTAssertEqual(TimeZone.americaVancouver.identifier, "America/Vancouver")

        XCTAssertEqual(TimeZone.americaWhitehorse.identifier, "America/Whitehorse")

        XCTAssertEqual(TimeZone.americaWinnipeg.identifier, "America/Winnipeg")

        XCTAssertEqual(TimeZone.americaYakutat.identifier, "America/Yakutat")

        XCTAssertEqual(TimeZone.americaYellowknife.identifier, "America/Yellowknife")

        XCTAssertEqual(TimeZone.antarcticaCasey.identifier, "Antarctica/Casey")

        XCTAssertEqual(TimeZone.antarcticaDavis.identifier, "Antarctica/Davis")

        XCTAssertEqual(TimeZone.antarcticaDumontdurville.identifier, "Antarctica/DumontDUrville")

        XCTAssertEqual(TimeZone.antarcticaMacquarie.identifier, "Antarctica/Macquarie")

        XCTAssertEqual(TimeZone.antarcticaMawson.identifier, "Antarctica/Mawson")

        XCTAssertEqual(TimeZone.antarcticaMcmurdo.identifier, "Antarctica/McMurdo")

        XCTAssertEqual(TimeZone.antarcticaPalmer.identifier, "Antarctica/Palmer")

        XCTAssertEqual(TimeZone.antarcticaRothera.identifier, "Antarctica/Rothera")

        XCTAssertEqual(TimeZone.antarcticaSouthPole.identifier, "Antarctica/South_Pole")

        XCTAssertEqual(TimeZone.antarcticaSyowa.identifier, "Antarctica/Syowa")

        XCTAssertEqual(TimeZone.antarcticaTroll.identifier, "Antarctica/Troll")

        XCTAssertEqual(TimeZone.antarcticaVostok.identifier, "Antarctica/Vostok")

        XCTAssertEqual(TimeZone.arcticLongyearbyen.identifier, "Arctic/Longyearbyen")

        XCTAssertEqual(TimeZone.asiaAden.identifier, "Asia/Aden")

        XCTAssertEqual(TimeZone.asiaAlmaty.identifier, "Asia/Almaty")

        XCTAssertEqual(TimeZone.asiaAmman.identifier, "Asia/Amman")

        XCTAssertEqual(TimeZone.asiaAnadyr.identifier, "Asia/Anadyr")

        XCTAssertEqual(TimeZone.asiaAqtau.identifier, "Asia/Aqtau")

        XCTAssertEqual(TimeZone.asiaAqtobe.identifier, "Asia/Aqtobe")

        XCTAssertEqual(TimeZone.asiaAshgabat.identifier, "Asia/Ashgabat")

        XCTAssertEqual(TimeZone.asiaAtyrau.identifier, "Asia/Atyrau")

        XCTAssertEqual(TimeZone.asiaBaghdad.identifier, "Asia/Baghdad")

        XCTAssertEqual(TimeZone.asiaBahrain.identifier, "Asia/Bahrain")

        XCTAssertEqual(TimeZone.asiaBaku.identifier, "Asia/Baku")

        XCTAssertEqual(TimeZone.asiaBangkok.identifier, "Asia/Bangkok")

        XCTAssertEqual(TimeZone.asiaBarnaul.identifier, "Asia/Barnaul")

        XCTAssertEqual(TimeZone.asiaBeirut.identifier, "Asia/Beirut")

        XCTAssertEqual(TimeZone.asiaBishkek.identifier, "Asia/Bishkek")

        XCTAssertEqual(TimeZone.asiaBrunei.identifier, "Asia/Brunei")

        XCTAssertEqual(TimeZone.asiaCalcutta.identifier, "Asia/Calcutta")

        XCTAssertEqual(TimeZone.asiaChita.identifier, "Asia/Chita")

        XCTAssertEqual(TimeZone.asiaChoibalsan.identifier, "Asia/Choibalsan")

        XCTAssertEqual(TimeZone.asiaChongqing.identifier, "Asia/Chongqing")

        XCTAssertEqual(TimeZone.asiaColombo.identifier, "Asia/Colombo")

        XCTAssertEqual(TimeZone.asiaDamascus.identifier, "Asia/Damascus")

        XCTAssertEqual(TimeZone.asiaDhaka.identifier, "Asia/Dhaka")

        XCTAssertEqual(TimeZone.asiaDili.identifier, "Asia/Dili")

        XCTAssertEqual(TimeZone.asiaDubai.identifier, "Asia/Dubai")

        XCTAssertEqual(TimeZone.asiaDushanbe.identifier, "Asia/Dushanbe")

        XCTAssertEqual(TimeZone.asiaFamagusta.identifier, "Asia/Famagusta")

        XCTAssertEqual(TimeZone.asiaGaza.identifier, "Asia/Gaza")

        XCTAssertEqual(TimeZone.asiaHarbin.identifier, "Asia/Harbin")

        XCTAssertEqual(TimeZone.asiaHebron.identifier, "Asia/Hebron")

        XCTAssertEqual(TimeZone.asiaHoChiMinh.identifier, "Asia/Ho_Chi_Minh")

        XCTAssertEqual(TimeZone.asiaHongKong.identifier, "Asia/Hong_Kong")

        XCTAssertEqual(TimeZone.asiaHovd.identifier, "Asia/Hovd")

        XCTAssertEqual(TimeZone.asiaIrkutsk.identifier, "Asia/Irkutsk")

        XCTAssertEqual(TimeZone.asiaJakarta.identifier, "Asia/Jakarta")

        XCTAssertEqual(TimeZone.asiaJayapura.identifier, "Asia/Jayapura")

        XCTAssertEqual(TimeZone.asiaJerusalem.identifier, "Asia/Jerusalem")

        XCTAssertEqual(TimeZone.asiaKabul.identifier, "Asia/Kabul")

        XCTAssertEqual(TimeZone.asiaKamchatka.identifier, "Asia/Kamchatka")

        XCTAssertEqual(TimeZone.asiaKarachi.identifier, "Asia/Karachi")

        XCTAssertEqual(TimeZone.asiaKashgar.identifier, "Asia/Kashgar")

        XCTAssertEqual(TimeZone.asiaKathmandu.identifier, "Asia/Kathmandu")

        XCTAssertEqual(TimeZone.asiaKatmandu.identifier, "Asia/Katmandu")

        XCTAssertEqual(TimeZone.asiaKhandyga.identifier, "Asia/Khandyga")

        XCTAssertEqual(TimeZone.asiaKrasnoyarsk.identifier, "Asia/Krasnoyarsk")

        XCTAssertEqual(TimeZone.asiaKualaLumpur.identifier, "Asia/Kuala_Lumpur")

        XCTAssertEqual(TimeZone.asiaKuching.identifier, "Asia/Kuching")

        XCTAssertEqual(TimeZone.asiaKuwait.identifier, "Asia/Kuwait")

        XCTAssertEqual(TimeZone.asiaMacau.identifier, "Asia/Macau")

        XCTAssertEqual(TimeZone.asiaMagadan.identifier, "Asia/Magadan")

        XCTAssertEqual(TimeZone.asiaMakassar.identifier, "Asia/Makassar")

        XCTAssertEqual(TimeZone.asiaManila.identifier, "Asia/Manila")

        XCTAssertEqual(TimeZone.asiaMuscat.identifier, "Asia/Muscat")

        XCTAssertEqual(TimeZone.asiaNicosia.identifier, "Asia/Nicosia")

        XCTAssertEqual(TimeZone.asiaNovokuznetsk.identifier, "Asia/Novokuznetsk")

        XCTAssertEqual(TimeZone.asiaNovosibirsk.identifier, "Asia/Novosibirsk")

        XCTAssertEqual(TimeZone.asiaOmsk.identifier, "Asia/Omsk")

        XCTAssertEqual(TimeZone.asiaOral.identifier, "Asia/Oral")

        XCTAssertEqual(TimeZone.asiaPhnomPenh.identifier, "Asia/Phnom_Penh")

        XCTAssertEqual(TimeZone.asiaPontianak.identifier, "Asia/Pontianak")

        XCTAssertEqual(TimeZone.asiaPyongyang.identifier, "Asia/Pyongyang")

        XCTAssertEqual(TimeZone.asiaQatar.identifier, "Asia/Qatar")

        XCTAssertEqual(TimeZone.asiaQostanay.identifier, "Asia/Qostanay")

        XCTAssertEqual(TimeZone.asiaQyzylorda.identifier, "Asia/Qyzylorda")

        XCTAssertEqual(TimeZone.asiaRangoon.identifier, "Asia/Rangoon")

        XCTAssertEqual(TimeZone.asiaRiyadh.identifier, "Asia/Riyadh")

        XCTAssertEqual(TimeZone.asiaSakhalin.identifier, "Asia/Sakhalin")

        XCTAssertEqual(TimeZone.asiaSamarkand.identifier, "Asia/Samarkand")

        XCTAssertEqual(TimeZone.asiaSeoul.identifier, "Asia/Seoul")

        XCTAssertEqual(TimeZone.asiaShanghai.identifier, "Asia/Shanghai")

        XCTAssertEqual(TimeZone.asiaSingapore.identifier, "Asia/Singapore")

        XCTAssertEqual(TimeZone.asiaSrednekolymsk.identifier, "Asia/Srednekolymsk")

        XCTAssertEqual(TimeZone.asiaTaipei.identifier, "Asia/Taipei")

        XCTAssertEqual(TimeZone.asiaTashkent.identifier, "Asia/Tashkent")

        XCTAssertEqual(TimeZone.asiaTbilisi.identifier, "Asia/Tbilisi")

        XCTAssertEqual(TimeZone.asiaTehran.identifier, "Asia/Tehran")

        XCTAssertEqual(TimeZone.asiaThimphu.identifier, "Asia/Thimphu")

        XCTAssertEqual(TimeZone.asiaTokyo.identifier, "Asia/Tokyo")

        XCTAssertEqual(TimeZone.asiaTomsk.identifier, "Asia/Tomsk")

        XCTAssertEqual(TimeZone.asiaUlaanbaatar.identifier, "Asia/Ulaanbaatar")

        XCTAssertEqual(TimeZone.asiaUrumqi.identifier, "Asia/Urumqi")

        XCTAssertEqual(TimeZone.asiaUstNera.identifier, "Asia/Ust-Nera")

        XCTAssertEqual(TimeZone.asiaVientiane.identifier, "Asia/Vientiane")

        XCTAssertEqual(TimeZone.asiaVladivostok.identifier, "Asia/Vladivostok")

        XCTAssertEqual(TimeZone.asiaYakutsk.identifier, "Asia/Yakutsk")

        XCTAssertEqual(TimeZone.asiaYangon.identifier, "Asia/Yangon")

        XCTAssertEqual(TimeZone.asiaYekaterinburg.identifier, "Asia/Yekaterinburg")

        XCTAssertEqual(TimeZone.asiaYerevan.identifier, "Asia/Yerevan")

        XCTAssertEqual(TimeZone.atlanticAzores.identifier, "Atlantic/Azores")

        XCTAssertEqual(TimeZone.atlanticBermuda.identifier, "Atlantic/Bermuda")

        XCTAssertEqual(TimeZone.atlanticCanary.identifier, "Atlantic/Canary")

        XCTAssertEqual(TimeZone.atlanticCapeVerde.identifier, "Atlantic/Cape_Verde")

        XCTAssertEqual(TimeZone.atlanticFaroe.identifier, "Atlantic/Faroe")

        XCTAssertEqual(TimeZone.atlanticMadeira.identifier, "Atlantic/Madeira")

        XCTAssertEqual(TimeZone.atlanticReykjavik.identifier, "Atlantic/Reykjavik")

        XCTAssertEqual(TimeZone.atlanticSouthGeorgia.identifier, "Atlantic/South_Georgia")

        XCTAssertEqual(TimeZone.atlanticStHelena.identifier, "Atlantic/St_Helena")

        XCTAssertEqual(TimeZone.atlanticStanley.identifier, "Atlantic/Stanley")

        XCTAssertEqual(TimeZone.australiaAdelaide.identifier, "Australia/Adelaide")

        XCTAssertEqual(TimeZone.australiaBrisbane.identifier, "Australia/Brisbane")

        XCTAssertEqual(TimeZone.australiaBrokenHill.identifier, "Australia/Broken_Hill")

        XCTAssertEqual(TimeZone.australiaCurrie.identifier, "Australia/Currie")

        XCTAssertEqual(TimeZone.australiaDarwin.identifier, "Australia/Darwin")

        XCTAssertEqual(TimeZone.australiaEucla.identifier, "Australia/Eucla")

        XCTAssertEqual(TimeZone.australiaHobart.identifier, "Australia/Hobart")

        XCTAssertEqual(TimeZone.australiaLindeman.identifier, "Australia/Lindeman")

        XCTAssertEqual(TimeZone.australiaLordHowe.identifier, "Australia/Lord_Howe")

        XCTAssertEqual(TimeZone.australiaMelbourne.identifier, "Australia/Melbourne")

        XCTAssertEqual(TimeZone.australiaPerth.identifier, "Australia/Perth")

        XCTAssertEqual(TimeZone.australiaSydney.identifier, "Australia/Sydney")

        XCTAssertEqual(TimeZone.europeAmsterdam.identifier, "Europe/Amsterdam")

        XCTAssertEqual(TimeZone.europeAndorra.identifier, "Europe/Andorra")

        XCTAssertEqual(TimeZone.europeAstrakhan.identifier, "Europe/Astrakhan")

        XCTAssertEqual(TimeZone.europeAthens.identifier, "Europe/Athens")

        XCTAssertEqual(TimeZone.europeBelgrade.identifier, "Europe/Belgrade")

        XCTAssertEqual(TimeZone.europeBerlin.identifier, "Europe/Berlin")

        XCTAssertEqual(TimeZone.europeBratislava.identifier, "Europe/Bratislava")

        XCTAssertEqual(TimeZone.europeBrussels.identifier, "Europe/Brussels")

        XCTAssertEqual(TimeZone.europeBucharest.identifier, "Europe/Bucharest")

        XCTAssertEqual(TimeZone.europeBudapest.identifier, "Europe/Budapest")

        XCTAssertEqual(TimeZone.europeBusingen.identifier, "Europe/Busingen")

        XCTAssertEqual(TimeZone.europeChisinau.identifier, "Europe/Chisinau")

        XCTAssertEqual(TimeZone.europeCopenhagen.identifier, "Europe/Copenhagen")

        XCTAssertEqual(TimeZone.europeDublin.identifier, "Europe/Dublin")

        XCTAssertEqual(TimeZone.europeGibraltar.identifier, "Europe/Gibraltar")

        XCTAssertEqual(TimeZone.europeGuernsey.identifier, "Europe/Guernsey")

        XCTAssertEqual(TimeZone.europeHelsinki.identifier, "Europe/Helsinki")

        XCTAssertEqual(TimeZone.europeIsleOfMan.identifier, "Europe/Isle_of_Man")

        XCTAssertEqual(TimeZone.europeIstanbul.identifier, "Europe/Istanbul")

        XCTAssertEqual(TimeZone.europeJersey.identifier, "Europe/Jersey")

        XCTAssertEqual(TimeZone.europeKaliningrad.identifier, "Europe/Kaliningrad")

        XCTAssertEqual(TimeZone.europeKiev.identifier, "Europe/Kiev")

        XCTAssertEqual(TimeZone.europeKirov.identifier, "Europe/Kirov")

        XCTAssertEqual(TimeZone.europeKyiv.identifier, "Europe/Kyiv")

        XCTAssertEqual(TimeZone.europeLisbon.identifier, "Europe/Lisbon")

        XCTAssertEqual(TimeZone.europeLjubljana.identifier, "Europe/Ljubljana")

        XCTAssertEqual(TimeZone.europeLondon.identifier, "Europe/London")

        XCTAssertEqual(TimeZone.europeLuxembourg.identifier, "Europe/Luxembourg")

        XCTAssertEqual(TimeZone.europeMadrid.identifier, "Europe/Madrid")

        XCTAssertEqual(TimeZone.europeMalta.identifier, "Europe/Malta")

        XCTAssertEqual(TimeZone.europeMariehamn.identifier, "Europe/Mariehamn")

        XCTAssertEqual(TimeZone.europeMinsk.identifier, "Europe/Minsk")

        XCTAssertEqual(TimeZone.europeMonaco.identifier, "Europe/Monaco")

        XCTAssertEqual(TimeZone.europeMoscow.identifier, "Europe/Moscow")

        XCTAssertEqual(TimeZone.europeOslo.identifier, "Europe/Oslo")

        XCTAssertEqual(TimeZone.europeParis.identifier, "Europe/Paris")

        XCTAssertEqual(TimeZone.europePodgorica.identifier, "Europe/Podgorica")

        XCTAssertEqual(TimeZone.europePrague.identifier, "Europe/Prague")

        XCTAssertEqual(TimeZone.europeRiga.identifier, "Europe/Riga")

        XCTAssertEqual(TimeZone.europeRome.identifier, "Europe/Rome")

        XCTAssertEqual(TimeZone.europeSamara.identifier, "Europe/Samara")

        XCTAssertEqual(TimeZone.europeSanMarino.identifier, "Europe/San_Marino")

        XCTAssertEqual(TimeZone.europeSarajevo.identifier, "Europe/Sarajevo")

        XCTAssertEqual(TimeZone.europeSaratov.identifier, "Europe/Saratov")

        XCTAssertEqual(TimeZone.europeSimferopol.identifier, "Europe/Simferopol")

        XCTAssertEqual(TimeZone.europeSkopje.identifier, "Europe/Skopje")

        XCTAssertEqual(TimeZone.europeSofia.identifier, "Europe/Sofia")

        XCTAssertEqual(TimeZone.europeStockholm.identifier, "Europe/Stockholm")

        XCTAssertEqual(TimeZone.europeTallinn.identifier, "Europe/Tallinn")

        XCTAssertEqual(TimeZone.europeTirane.identifier, "Europe/Tirane")

        XCTAssertEqual(TimeZone.europeUlyanovsk.identifier, "Europe/Ulyanovsk")

        XCTAssertEqual(TimeZone.europeUzhgorod.identifier, "Europe/Uzhgorod")

        XCTAssertEqual(TimeZone.europeVaduz.identifier, "Europe/Vaduz")

        XCTAssertEqual(TimeZone.europeVatican.identifier, "Europe/Vatican")

        XCTAssertEqual(TimeZone.europeVienna.identifier, "Europe/Vienna")

        XCTAssertEqual(TimeZone.europeVilnius.identifier, "Europe/Vilnius")

        XCTAssertEqual(TimeZone.europeVolgograd.identifier, "Europe/Volgograd")

        XCTAssertEqual(TimeZone.europeWarsaw.identifier, "Europe/Warsaw")

        XCTAssertEqual(TimeZone.europeZagreb.identifier, "Europe/Zagreb")

        XCTAssertEqual(TimeZone.europeZaporozhye.identifier, "Europe/Zaporozhye")

        XCTAssertEqual(TimeZone.europeZurich.identifier, "Europe/Zurich")

        XCTAssertEqual(TimeZone.gmt.identifier, "GMT")

        XCTAssertEqual(TimeZone.indianAntananarivo.identifier, "Indian/Antananarivo")

        XCTAssertEqual(TimeZone.indianChagos.identifier, "Indian/Chagos")

        XCTAssertEqual(TimeZone.indianChristmas.identifier, "Indian/Christmas")

        XCTAssertEqual(TimeZone.indianCocos.identifier, "Indian/Cocos")

        XCTAssertEqual(TimeZone.indianComoro.identifier, "Indian/Comoro")

        XCTAssertEqual(TimeZone.indianKerguelen.identifier, "Indian/Kerguelen")

        XCTAssertEqual(TimeZone.indianMahe.identifier, "Indian/Mahe")

        XCTAssertEqual(TimeZone.indianMaldives.identifier, "Indian/Maldives")

        XCTAssertEqual(TimeZone.indianMauritius.identifier, "Indian/Mauritius")

        XCTAssertEqual(TimeZone.indianMayotte.identifier, "Indian/Mayotte")

        XCTAssertEqual(TimeZone.indianReunion.identifier, "Indian/Reunion")

        XCTAssertEqual(TimeZone.pacificApia.identifier, "Pacific/Apia")

        XCTAssertEqual(TimeZone.pacificAuckland.identifier, "Pacific/Auckland")

        XCTAssertEqual(TimeZone.pacificBougainville.identifier, "Pacific/Bougainville")

        XCTAssertEqual(TimeZone.pacificChatham.identifier, "Pacific/Chatham")

        XCTAssertEqual(TimeZone.pacificChuuk.identifier, "Pacific/Chuuk")

        XCTAssertEqual(TimeZone.pacificEaster.identifier, "Pacific/Easter")

        XCTAssertEqual(TimeZone.pacificEfate.identifier, "Pacific/Efate")

        XCTAssertEqual(TimeZone.pacificEnderbury.identifier, "Pacific/Enderbury")

        XCTAssertEqual(TimeZone.pacificFakaofo.identifier, "Pacific/Fakaofo")

        XCTAssertEqual(TimeZone.pacificFiji.identifier, "Pacific/Fiji")

        XCTAssertEqual(TimeZone.pacificFunafuti.identifier, "Pacific/Funafuti")

        XCTAssertEqual(TimeZone.pacificGalapagos.identifier, "Pacific/Galapagos")

        XCTAssertEqual(TimeZone.pacificGambier.identifier, "Pacific/Gambier")

        XCTAssertEqual(TimeZone.pacificGuadalcanal.identifier, "Pacific/Guadalcanal")

        XCTAssertEqual(TimeZone.pacificGuam.identifier, "Pacific/Guam")

        XCTAssertEqual(TimeZone.pacificHonolulu.identifier, "Pacific/Honolulu")

        XCTAssertEqual(TimeZone.pacificJohnston.identifier, "Pacific/Johnston")

        XCTAssertEqual(TimeZone.pacificKanton.identifier, "Pacific/Kanton")

        XCTAssertEqual(TimeZone.pacificKiritimati.identifier, "Pacific/Kiritimati")

        XCTAssertEqual(TimeZone.pacificKosrae.identifier, "Pacific/Kosrae")

        XCTAssertEqual(TimeZone.pacificKwajalein.identifier, "Pacific/Kwajalein")

        XCTAssertEqual(TimeZone.pacificMajuro.identifier, "Pacific/Majuro")

        XCTAssertEqual(TimeZone.pacificMarquesas.identifier, "Pacific/Marquesas")

        XCTAssertEqual(TimeZone.pacificMidway.identifier, "Pacific/Midway")

        XCTAssertEqual(TimeZone.pacificNauru.identifier, "Pacific/Nauru")

        XCTAssertEqual(TimeZone.pacificNiue.identifier, "Pacific/Niue")

        XCTAssertEqual(TimeZone.pacificNorfolk.identifier, "Pacific/Norfolk")

        XCTAssertEqual(TimeZone.pacificNoumea.identifier, "Pacific/Noumea")

        XCTAssertEqual(TimeZone.pacificPagoPago.identifier, "Pacific/Pago_Pago")

        XCTAssertEqual(TimeZone.pacificPalau.identifier, "Pacific/Palau")

        XCTAssertEqual(TimeZone.pacificPitcairn.identifier, "Pacific/Pitcairn")

        XCTAssertEqual(TimeZone.pacificPohnpei.identifier, "Pacific/Pohnpei")

        XCTAssertEqual(TimeZone.pacificPonape.identifier, "Pacific/Ponape")

        XCTAssertEqual(TimeZone.pacificPortMoresby.identifier, "Pacific/Port_Moresby")

        XCTAssertEqual(TimeZone.pacificRarotonga.identifier, "Pacific/Rarotonga")

        XCTAssertEqual(TimeZone.pacificSaipan.identifier, "Pacific/Saipan")

        XCTAssertEqual(TimeZone.pacificTahiti.identifier, "Pacific/Tahiti")

        XCTAssertEqual(TimeZone.pacificTarawa.identifier, "Pacific/Tarawa")

        XCTAssertEqual(TimeZone.pacificTongatapu.identifier, "Pacific/Tongatapu")

        XCTAssertEqual(TimeZone.pacificTruk.identifier, "Pacific/Truk")

        XCTAssertEqual(TimeZone.pacificWake.identifier, "Pacific/Wake")

        XCTAssertEqual(TimeZone.pacificWallis.identifier, "Pacific/Wallis")
    }
}
