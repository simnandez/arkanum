/* === This file is part of Calamares - <http://github.com/calamares> ===
 *
 * (Copyright and license details omitted for brevity)
 *
 * You should have received a copy of the GNU General Public License
 * along with Calamares. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    function nextSlide() {
        console.log("QML Component (default slideshow) Next slide");
        presentation.goToNextSlide();
    }

    Timer {
        id: advanceTimer
        interval: 7500
        running: true
        repeat: true
        onTriggered: nextSlide()
    }

    // --- SLIDE 1 ---
    Slide {
        Image {
            id: reproductiveSystem
            source: "slider_1.png"
            anchors.centerIn: parent // CORRETTO: Centrato nel contenitore (Slide)
            width: 810
            height: 485
            fillMode: Image.PreserveAspectFit
        }
    }

    // --- SLIDE 2 ---
    Slide {
        Image {
            id: startReproduction
            source: "slider_2.png"
            anchors.centerIn: parent // CORRETTO
            width: 810
            height: 485
            fillMode: Image.PreserveAspectFit
        }
    }

    // --- SLIDE 3 ---
    Slide {
        Image {
            id: itsYourSystem
            source: "slider_3.png"
            anchors.centerIn: parent // CORRETTO
            width: 810
            height: 485
            fillMode: Image.PreserveAspectFit
        }
    }

    // --- SLIDE 4 ---
    Slide {
        Image {
            id: eggsPresentation
            source: "slider_4.png"
            anchors.centerIn: parent // CORRETTO
            width: 810
            height: 485
            fillMode: Image.PreserveAspectFit
        }
    }

    // --- SLIDE 5 ---
    Slide {
        Image {
            id: waitHatching
            source: "slider_5.png"
            anchors.centerIn: parent // CORRETTO
            width: 810
            height: 485
            fillMode: Image.PreserveAspectFit
        }
    }

    // --- SLIDE 6 ---
    Slide {
        Image {
            id: followPenguins
            source: "slider_6.png"
            anchors.centerIn: parent // CORRETTO
            width: 810
            height: 485
            fillMode: Image.PreserveAspectFit
        }
    }

    // --- SLIDE 7 ---
    Slide {
        Image {
            id: createdBy
            source: "slider_7.png"
            anchors.centerIn: parent // CORRETTO
            width: 810
            height: 485
            fillMode: Image.PreserveAspectFit
        }
    }
    
    function onActivate() {
        console.log("QML Component (default slideshow) activated");
        presentation.currentSlide = 0;
    }

    function onLeave() {
        console.log("QML Component (default slideshow) deactivated");
    }
}
