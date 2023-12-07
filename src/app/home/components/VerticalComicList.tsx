import Comic from "../../comic/page";
import ComicItem from "./ComicItem";

export default function VerticalComicList({
  comicList,
}: {
  comicList: { id: number; title: string; thumb: string }[];
}) {
  return (
    <div style={{ padding: 20, background: "white" }}>
      {comicList.map((item, index) => (
        <ComicItem
          key={index}
          props={{
            title: item.title,
            image: item.thumb,
            path: "",
            width: "",
          }}
        />
      ))}
    </div>
  );
}
