import Comic from "../../comic/page";
import ComicItem from "./ComicItem";

export default function VerticalComicList({comicList=[{id:0, title:"", thumb:""}]}){
    return <div style={{padding:20, background:"white"}}>
        {comicList.map((item, index) =>
            <ComicItem key={index} title={item.title} image={item.thumb} path={"/comic?id=" + item.id} width={"50%"}/>
        )}
    </div>
}