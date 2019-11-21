//
//  TeamManager
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

class TeamManager
{
    static func getFullTeamName(_ name: String) -> String
    {
        let teamNames = ["ANA":"Anaheim Ducks", "ARI":"Arizona Coytotes", "BOS":"Boston Bruins", "BUF":"Buffalo Sabres", "CGY":"Calgary Flames", "CAR":"Carolina Hurricanes", "CHI":"Chicago Blackhawks", "COL":"Colorado Avalanche", "CBJ":"Columbus Blue Jackets", "DAL":"Dallas Stars", "DET":"Detroit Red Wings", "EDM":"Edmonton Oilers","FLO":"Florida Panthers", "LAK":"Los Angeles Kings", "MIN":"Minnesota Wild", "MTL":"Montreal Canadiens", "NSH":"Nashville Predators", "NJD":"New Jersey Devils", "NYI":"New York Islanders", "NYR":"New York Rangers", "OTT":"Ottawa Senators", "PHI":"Philadelphia Flyers", "PIT":"Pittsburgh Penguins", "SJS":"San Jose Sharks", "STL":"St. Louis Blues","TBL":"Tampa Bay Lightning", "TOR":"Toronto Maple Leafs", "VAN":"Vancouver Canucks", "VGK":"Vegas Golden Knights", "WSH":"Washington Capitals", "WPJ":"Winnipeg Jets"]
        
        return teamNames[name] ?? ""
    }
    
    static func getTeamCityName(_ name: String) -> String
    {
        let teamNames = ["ANA":"Anaheim", "ARI":"Arizona", "BOS":"Boston", "BUF":"Buffalo", "CGY":"Calgary", "CAR":"Carolina", "CHI":"Chicago", "COL":"Colorado", "CBJ":"Columbus", "DAL":"Dallas", "DET":"Detroit", "EDM":"Edmonton","FLO":"Florida", "LAK":"Los Angeles", "MIN":"Minnesota", "MTL":"Montreal", "NSH":"Nashville", "NJD":"New Jersey", "NYI":"NY Islanders", "NYR":"NY Rangers", "OTT":"Ottawa", "PHI":"Philadelphia", "PIT":"Pittsburgh", "SJS":"San Jose", "STL":"St. Louis","TBL":"Tampa Bay", "TOR":"Toronto", "VAN":"Vancouver", "VGK":"Las Vegas", "WSH":"Washington", "WPJ":"Winnipeg"]
        
        return teamNames[name] ?? ""
    }
    
    static func getTeamName(_ name: String) -> String
    {
        let teamNames = ["ANA":"Ducks", "ARI":"Coytotes", "BOS":"Bruins", "BUF":"Sabres", "CGY":"Flames", "CAR":"Hurricanes", "CHI":"Blackhawks", "COL":"Avalanche", "CBJ":"Blue Jackets", "DAL":"Stars", "DET":"Red Wings", "EDM":"Oilers", "FLO":"Panthers", "LAK":"Kings", "MIN":"Wild", "MTL":"Canadiens", "NSH":"Predators", "NJD":"Devils", "NYI":"Islanders", "NYR":"Rangers", "OTT":"Senators", "PHI":"Flyers", "PIT":"Penguins", "SJS":"Sharks", "STL":"Blues", "TBL":"Lightning", "TOR":"Maple Leafs", "VAN":"Canucks", "VGK":"Golden Knights", "WSH":"Capitals", "WPJ":"Jets"]
        
        return teamNames[name] ?? ""
    }
    
    static func getIDByTeam(_ name: String) -> Int
    {
        let teamNames = ["ANA":29, "ARI":30, "BOS":11, "BUF":15, "CGY":23, "CAR":3, "CHI":20, "COL":22, "CBJ":19, "DAL":27, "DET":16, "EDM":24, "FLO":4, "LAK":28, "MIN":25, "MTL":14, "NSH":18, "NJD":7, "NYI":8, "NYR":9, "OTT":13, "PHI":6, "PIT":10, "SJS":26, "STL":17, "TBL":1, "TOR":12, "VAN":21, "VGK":142, "WSH":5, "WPJ":2]
        
        return teamNames[name]!
    }
    
    static func getDivisionByTeam(_ name: String) -> String
    {
        let teamNames = ["ANA":"Pacific", "ARI":"Pacific", "BOS":"Atlantic", "BUF":"Atlantic", "CGY":"Pacific", "CAR":"Metropolitan", "CHI":"Central", "COL":"Central", "CBJ":"Metropolitan", "DAL":"Central", "DET":"Atlantic", "EDM":"Pacific", "FLO":"Atlantic", "LAK":"Pacific", "MIN":"Central", "MTL":"Atlantic", "NSH":"Central", "NJD":"Metropolitan", "NYI":"Metropolitan", "NYR":"Metropolitan", "OTT":"Atlantic", "PHI":"Metropolitan", "PIT":"Metropolitan", "SJS":"Pacific", "STL":"Central", "TBL":"Atlantic", "TOR":"Atlantic", "VAN":"Pacific", "VGK":"Pacific", "WSH":"Metropolitan", "WPJ":"Central"]
        
        return teamNames[name]!
    }
    
    static func getConferenceByTeam(_ name: String) -> String
    {
        let teamNames = ["ANA":"Western", "ARI":"Western", "BOS":"Eastern", "BUF":"Eastern", "CGY":"Western", "CAR":"Eastern", "CHI":"Western", "COL":"Western", "CBJ":"Eastern", "DAL":"Western", "DET":"Eastern", "EDM":"Western", "FLO":"Eastern", "LAK":"Western", "MIN":"Western", "MTL":"Eastern", "NSH":"Western", "NJD":"Eastern", "NYI":"Eastern", "NYR":"Eastern", "OTT":"Eastern", "PHI":"Eastern", "PIT":"Eastern", "SJS":"Western", "STL":"Western", "TBL":"Eastern", "TOR":"Eastern", "VAN":"Western", "VGK":"Western", "WSH":"Eastern", "WPJ":"Western"]
        
        return teamNames[name]!
    }
    
    static func getTeamByID(_ teamId: Int) -> String
    {
        let teamIds = [29:"ANA", 30:"ARI", 11:"BOS", 15:"BUF", 23:"CGY", 3:"CAR", 20:"CHI", 22:"COL", 19:"CBJ", 27:"DAL", 16:"DET", 24:"EDM", 4:"FLO", 28:"LAK", 25:"MIN", 14:"MTL", 18:"NSH", 7:"NJD", 8:"NYI", 9:"NYR", 13:"OTT", 6:"PHI", 10:"PIT", 26:"SJS", 17:"STL", 1:"TBL", 12:"TOR", 21:"VAN", 142:"VGK", 5:"WSH", 2:"WPJ"]
        
        return teamIds[teamId]!
    }
    
    static func getVenueNameByTeam(_ name: String) -> String
    {
        let teamVenues = ["ANA":"Honda Center", "ARI":"Gila River Arena", "BOS":"TD Garden", "BUF":"KeyBank Center", "CGY":"Scotiabank Saddledome", "CAR":"PNC Arena", "CHI":"United Center", "COL":"Pepsi Center", "CBJ":"Nationwide Arena", "DAL":"American Airlines Center", "DET":"Little Caesars Arena", "EDM":"Rogers Place", "FLO":"BB&T Center", "LAK":"Staples Center", "MIN":"Xcel Energy Center", "MTL":"Bell Centre", "NSH":"Bridgestone Arena", "NJD":"Prudential Center", "NYI":"Nassau Veterans Memorial Coliseum", "NYR":"Madison Square Garden", "OTT":"Canadian Tire Centre", "PHI":"Wells Fargo Center", "PIT":"PPG Paints Arena", "SJS":"SAP Center at San Jose", "STL":"Enterprise Center", "TBL":"Amalie Arena", "TOR":"Scotiabank Arena", "VAN":"Rogers Arena", "VGK":"T-Mobile Arena", "WSH":"Capital One Arena", "WPJ":"Bell MTS Place"]
        
        return teamVenues[name] ?? ""
    }
    
    static func getVenueByTeam(_ name: String) -> Venue
    {
        let teamVenues = [
            "ANA":Venue(imageName: "ANA", teamName: "Anaheim Ducks", venueName: "Honda Center", seating: 17174, address: "2695 East Katella Ave, Anaheim, CA 92806", latitude: 33.80778, longitude: -117.876667),
            "ARI":Venue(imageName: "ARI", teamName: "Arizona Coytotes", venueName: "Gila River Arena", seating: 17125, address: "9400 West Maryland Avenue, Glendale, AZ 85305", latitude: 33.531944, longitude: -112.261111),
            "BOS":Venue(imageName: "BOS", teamName: "Boston Bruins", venueName: "TD Garden", seating: 17565, address: "100 Legends Way, Boston, MA 02114", latitude: 42.366303, longitude: -71.062228),
            "BUF":Venue(imageName: "BUF", teamName: "Buffalo Sabres", venueName: "Key Bank Center", seating: 19070, address: "1 Seymour H. Knox III Plaza, Buffalo, NY 14203", latitude: 42.875, longitude: -78.876389),
            "CGY":Venue(imageName: "CGY", teamName: "Calgary Flames", venueName: "Scotiabank Saddledome", seating: 19289, address: "555 Saddledome Rise SE, Calgary, Alberta T2G 2W1, Canada", latitude: 51.0375, longitude: -114.051944),
            "CAR":Venue(imageName: "CAR", teamName: "Carolina Hurricanes", venueName: "PNC Arena", seating: 18680, address: "1400 Edwards Mill Rd, Raleigh, NC 27607", latitude: 35.803333, longitude: -78.721944),
            "CHI":Venue(imageName: "CHI", teamName: "Chicago Blackhawks", venueName: "United Center", seating: 23500, address: "1901 W Madison St, Chicago, IL 60612", latitude: 41.880556, longitude: -87.674167),
            "COL":Venue(imageName: "COL", teamName: "Colorado Avalanche", venueName: "Pepsi Center", seating: 18007, address: "1000 Chopper Cir, Denver, CO 80204", latitude: 39.748611, longitude: -105.0075),
            "CBJ":Venue(imageName: "CBJ", teamName: "Columbus Blue Jackets", venueName: "Nationwide Arena", seating: 20000, address: "200 W Nationwide Blvd, Columbus, OH 43215", latitude: 39.969283, longitude: -83.006111),
            "DAL":Venue(imageName: "DAL", teamName: "Dallas Stars", venueName: "American Airlines Center", seating: 20000, address: "2500 Victory Ave, Dallas, TX 75219", latitude: 32.790556, longitude: -96.810278),
            "DET":Venue(imageName: "DET", teamName: "Detroit Red Wings", venueName: "Little Caesars Arena", seating: 19515, address: "2645 Woodward Ave, Detroit, MI 48201", latitude: 42.341111, longitude: -83.055),
            "EDM":Venue(imageName: "EDM", teamName: "Edmonton Oilers", venueName: "Rogers Place", seating: 18347, address: "10220 104 Ave NW, Edmonton, AB T5H 2X6, Canada", latitude: 53.546944, longitude: -113.497778),
            "FLO":Venue(imageName: "FLO", teamName: "Florida Panthers", venueName: "BB&T Center", seating: 20737, address: "1 Panther Pkwy, Sunrise, FL 33323", latitude: 26.158333, longitude: -80.325556),
            "LAK":Venue(imageName: "LAK", teamName: "Los Angeles Kings", venueName: "Staples Center", seating: 21000, address: "1111 S Figueroa St, Los Angeles, CA 90015", latitude: 34.043056, longitude: -118.267222),
            "MIN":Venue(imageName: "MIN", teamName: "Minnesota Wild", venueName: "Xcel Energy Center", seating: 20554, address: "199 W Kellogg Blvd, St Paul, MN 55102", latitude: 44.944722, longitude: -93.101111),
            "MTL":Venue(imageName: "MTL", teamName: "Montreal Canadiens", venueName: "Bell Centre", seating: 21273, address: "1909 Avenue des Canadiens-de-Montréal, Montréal, QC H4B 5G0, Canada", latitude: 45.496111, longitude: -73.569444),
            "NSH":Venue(imageName: "NSH", teamName: "Nashville Predators", venueName: "Bridgestone Arena", seating: 19500, address: "501 Broadway, Nashville, TN 37203", latitude: 36.159167, longitude: -86.778611),
            "NJD":Venue(imageName: "NJD", teamName: "New Jersey Devils", venueName: "Prudential Center", seating: 16514, address: "25 Lafayette St, Newark, NJ 07102", latitude: 40.733611, longitude: -74.171111),
            "NYI":Venue(imageName: "NYI", teamName: "New York Islanders", venueName: "Barclays Center", seating: 19000, address: "620 Atlantic Ave, Brooklyn, NY 11217", latitude: 40.682661, longitude: -73.975225),
            "NYR":Venue(imageName: "NYR", teamName: "New York Rangers", venueName: "Madison Square Garden", seating: 20789, address: "4 Pennsylvania Plaza, New York, NY 10001", latitude: 40.750556, longitude: -73.993611),
            "OTT":Venue(imageName: "OTT", teamName: "Ottawa Senators", venueName: "Canadian Tire Centre", seating: 17000, address: "1000 Palladium Dr, Ottawa, ON K2V 1A5, Canada", latitude: 45.296944, longitude: -75.927222),
            "PHI":Venue(imageName: "PHI", teamName: "Philadelphia Flyers", venueName: "Wells Fargo Center", seating: 19500, address: "3601 S Broad St, Philadelphia, PA 19148", latitude: 39.901111, longitude: -75.171944),
            "PIT":Venue(imageName: "PIT", teamName: "Pittsburgh Penguins", venueName: "PPG Paints Arena", seating: 19758, address: "1001 Fifth Ave, Pittsburgh, PA 15219", latitude: 40.439444, longitude: -79.989167),
            "SJS":Venue(imageName: "SJS", teamName: "San Jose Sharks", venueName: "SAP Center", seating: 17496, address: "525 W Santa Clara St, San Jose, CA 95113", latitude: 37.332778, longitude: -121.901111),
            "STL":Venue(imageName: "STL", teamName: "St. Louis Blues", venueName: "Enterprise Center", seating: 19260, address: "1401 Clark Ave, St. Louis, MO 63103", latitude: 38.626667, longitude: -90.2025),
            "TBL":Venue(imageName: "TBL", teamName: "Tampa Bay Lightning", venueName: "Amalie Arena", seating: 20500, address: "401 Channelside Dr, Tampa, FL 33602", latitude: 27.942778, longitude: -82.451944),
            "TOR":Venue(imageName: "TOR", teamName: "Toronto Maple Leafs", venueName: "Scotiabank Arena", seating: 19800, address: "40 Bay St, Toronto, ON M5J 2X2, Canada", latitude: 43.643333, longitude: -79.379167),
            "VAN":Venue(imageName: "VAN", teamName: "Vancouver Canucks", venueName: "Rogers Arena", seating: 18910, address: "800 Griffiths Way, Vancouver, BC V6B 6G1, Canada", latitude: 49.277778, longitude: -123.108889),
            "VGK":Venue(imageName: "VGK", teamName: "Vegas Golden Knights", venueName: "T-Mobile Arena", seating: 17500, address: "3780 S Las Vegas Blvd, Las Vegas, NV 89158", latitude: 36.102778, longitude: -115.178333),
            "WSH":Venue(imageName: "WSH", teamName: "Washington Capitals", venueName: "Capital One Arena", seating: 20356, address: "601 F St NW, Washington, DC 20004", latitude: 38.898056, longitude: -77.020833),
            "WPJ":Venue(imageName: "WPJ", teamName: "Winnipeg Jets", venueName: "Bell MTS Place", seating: 16345, address: "300 Portage Ave, Winnipeg, MB R3K 1W4, Canada", latitude: 49.892778, longitude: -97.143611)
        ]
        
        return teamVenues[name]!
    }
}
