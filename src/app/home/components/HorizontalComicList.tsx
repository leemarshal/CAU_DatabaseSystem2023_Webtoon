import ComicItem from "./ComicItem";

export default function HorizontalComicList({comicList=[{id:0, title:"", thumb:""}]}){
    return <div style={{padding:20, overflow:"scroll", whiteSpace:"nowrap", background:"white"}}>
        {comicList.map((item, index) =>
            <ComicItem key={index} title={item.title} image={item.thumb} path={"/comic?id=" + item.id} width={"45%"}/>
        )}
    </div>
}