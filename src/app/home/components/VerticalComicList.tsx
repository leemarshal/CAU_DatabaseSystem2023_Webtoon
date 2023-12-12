import Comic from "../../comic/page";
import ComicItem from "./ComicItem";

export default function VerticalComicList({
  props,
}: {
  props: {
    comicList: {
      WebtoonID: number;
      Title: string | null;
      ThumbnailURL: string | null;
    }[];
  };
}) {
  return (
    <div className={"flex flex-wrap flex-start justify-stretch"}>
      {props.comicList.map((item, index) => (
        <ComicItem
          key={index}
          props={{
            title: item.Title ?? "",
            image: item.ThumbnailURL ?? "",
            path: "/comic?id=" + item.WebtoonID,
          }}
        />
      ))}
    </div>
  );
}
