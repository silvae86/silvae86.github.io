---
layout: page
title: Tools for your research workflow
---

These are some useful tools for Masters and PhD students that want to spend their time doing research instead of mundane problems such as bibliography organisation, crashing programs and lost data one week before the delivery(!), among others.

## Document format: LaTeX

Microsoft Word and its open-source siblings (WYSIWYG text processors) are good for 2 things:

  - Shopping lists (but not too long, just the groceries for 1 week)
  - Recommendation letters

Please do NOT use Microsoft Word for writing your dissertation. Makes my work hard because I need to install it, track changes, email numerous documents that drain my hard drive quota, etc.

I have heard great things about Office 365, but it still does not solve the bibliography management problems as far as I know, and keeps me, and my works, chained to a specific vendor.

Another thing I do not like about Word for research documents is that research writing is a creative process, and Word is simply not designed for creative writing. When you want to just write your thoughts as they flow, the last thing you need is 30 different buttons to remind you that you need to use styles, format with bold, italic, click click click to add a reference here and there... Just you and your text, that is all you need. And LaTeX produces beautiful documents according to actual typographic and editing standards made by people who know much more about it than me! Why fight with your editor to get something beautiful out of it? And page breaks? Give ME a break!

If you want to read more about why I think LaTeX is the best choice for scientific writing, read [this opinion post](/latex/scientific/writing/tools/2018/10/28/why-latex-is-the-best-for-scientific-writing).

## Online document editing: Overleaf

[Overleaf](https://www.overleaf.com/) is a great online platform for scientific writers. It is basically a collaborative text editor with syntax highlighting for TeX and an automatic compilation feature that allows you to see the changes made to your document as you type. It is as close to a WYSIWYG experience for LaTeX writing as you can get on the web.

## Reference Management: Mendeley

[Mendeley](https://www.mendeley.com/download-desktop/) is a reference manager that allows you to easily store all your references. It provides 3 main capabilities (in my opinion):

1. **Cloud Synchronization**. If you work across several computers, Mendeley will sync your references database across them all, and you are not
2. **"Automatic" bibliographic record fetching**. You can drag and drop the PDFs of your papers to the Mendeley app and it will try to automatically fetch the bibliographic record and fill in the bibliographic entry for you. It does not always work, though, so you need to keep an eye on the right sidebar of mendeley to check for wrong records.
3. **Note-taking and highlighting**. You can take notes and highlight interesting parts of your PDFs directly in Mendeley. I do not recommend making all your highlighting in the app and instead use your favorite PDF editor (such as the Mac Preview). Why you ask? Because if you copy the PDF from your Mendeley Library into a pendrive, for example, the notes are not actually saved in the PDF but in Mendeley servers and overlaid over the PDF when you use the Mendeley app. If you do not want to keep your notes chained to Mendeley, use right-click -> "Open File Externally..." to launch the PDF reader, edit what you want and when you are finished Mendeley will sync the updated PDF to the cloud.

## Overall record-keeping

Throughout your dissertation you will most certainly produce a lot of records of your research activity: reading sheets, experiment results, personal thoughts, etc.

To store these, you can use something so simple as Google Docs or Google Keep for flat notes, or a Wiki such as GitHub Wiki or a Dokuwiki. I also added Mendeley here because while it is not a full-fledged wiki, it can be used to keep track of reading notes attached to your references. The free-text search of Mendeley will also index your notes, making it possible to find the reference you want by something you have written in your notes.


|             | Search | Looks  | Structure | Installation | Maintainability | Syntax        |
|-------------|--------|--------|-----------|--------------|-----------------|---------------|
| Google Keep | *****  | ***    | *         | *****        | *****           | No Syntax     |
| Google Docs | **     | ****   | *         | *****        | *****           | WYSIWYG       |
| Dokuwiki    | *****  | ****   | *****     | ***          | ***             | Dokuwiki      |
| Github Wiki | ****   | *****  | ***       | ****         | ****            | Markdown      |
| Mendeley    | *****  | **     | *         | *****        | **              | WYSIWYG (?)   |

*Comparison of the main features of different platforms in the research workflow*{:class="img-caption"}

**Search**. It should be possible to retrieve your notes quickly with a search feature. In this case, Google Keep and Dokuwiki offer a fast querying interface to quickly find what you need. Google Docs buries the text in different documents, making it confusing to fetch what you need with a simple Ctrl+F.

**Looks**. The overall aspect of your notes, as you make them. This is subjective, of course. In my opinion, the GitHub wiki is the best-looking of the bunch, with its online interface. Mendeley gets the worst grade not because of its overall interface, but for its limited ability to add formatting to your reading notes and the tiny text box you have at your disposal to write them. You are not supposed to write very long texts there, so, this is somewhat of a moot point.

**Structure**. If you want to just take a few notes and search them, even a simple text file will do. However, as your work grows and different products of your research start appearing, you may need to separate them into categories or "folders".

Some examples are:

  - Reading notes: Do you need a section to store all your reading notes in a separate "folder"?
  - Task logs: Task descriptions, times of conclusion, comments and lessons learned...
  - Meeting records: Are you writing down what is said in meetings?
  - Experiment records: Are you performing user inquiries? Are you running experiments? For every experiment where you record user performance across several tasks you should make an experiment record

As you can see, as this starts to mount you will need to create document subsets. These start as folders and subfolders in your local hard drive, and still be somewhat searchable for quick retrieval of information. If all you want is quick retrieval, it may be enough, but if you want to establish links between such documents you may want to set up a [DokuWiki](https://www.dokuwiki.org/dokuwiki) in your [http://gnomo.fe.up.pt](FEUP web area) or [https://help.github.com/articles/about-github-wikis/](GitHub Wiki) as part of your repository. GitHub also provides free private repositories for members of the educational community in the form of the [Student Pack](https://education.github.com/pack).

Introduce structure as a way to organise a process that starts to become chaotic. Building a wiki adds some bureaucratic overhead to your research activity; if you are not supposed to deliver an online web page for your dissertation project, the wikis become less attractive/necessary. An alternative to a centralised wiki with many linked sections and pages can therefore be:

- For reading sheets in a searchable way -> Use [Mendeley's Notes](#markdown_notes) in the sidebar for this, as seen in the previous
- For task control software to measure your progress -> Use a free project management solution, such as [FreedCamp](https://freedcamp.com/) or others.
- For meeting and experiment records -> Use a combination of FreedCamp tasks and links to a Google Drive folder for your dissertation, where you create subfolders and place Google [Docs](https://docs.google.com) and [Sheets](https://docs.google.com). You can copy the "sharing links" from your Google Docs to every task in your FreedCamp Tasks and keep track of where the related documents are.

<a name="markdown_notes"></a>
![Mendeley Notes](/assets/images/dissertations/mendeley_notes.png){:class="img-center"}
*Notes in the Mendeley interface*{:class="img-caption"}

**Installation**

Pretty self-explanatory. How hard is it to get this solution running? Do you need to use a terminal shell or just register for an online platform? In this category, Dokuwiki gets the worst grade because it requires basic interaction with a terminal, while the others all have a graphical user interface for installation or are purely web-based and therefore require no installation.

**Maintainability**

In this category, I grade Google Keep, Google Docs and GitHub wiki the highest, as they are maintained by large companies and require no maintenance on the user's part. It is also rather easy to get your data out of the platform by saving the contents as text files or Markdown files. GitHub wiki loses a point because it [requires](https://help.github.com/articles/adding-and-editing-wiki-pages-locally/) the use of a terminal or a Git client to get your wiki out of the platform, but it is higher than Dokuwiki because the wiki infrastructure is automatically kept up to date always. Dokuwiki can sometimes be hard to keep up to date, especially if you need to install plugins. The worst for me is Mendeley because it is very hard to migrate out of Mendeley into another solution. Notes are attached to the Mendeley reference manager GUI, as well as highlights you make on your publications using the Mendeley client. It is a very nice to use platform, but you are locked to the vendor and free storage is [limited](https://blog.mendeley.com/tag/mendeley-storage-limits/); keep that in mind if you are going to manage very large bibliographic databases.

### Backups and data safeguarding: Cloud storage

You can use external hard drives to store your dissertation and all related materials, but those can die at the worst possible moments. Use [Google Drive](https://www.google.com/drive/), [Dropbox](https://www.dropbox.com), or any other cloud storage solution to keep regular backups. If you are afraid that someone can steal your work if your cloud provider gets hacked, just compress the stuff into a ZIP, 7z or RAR archive, and encrypt it with a strong key before you upload it to the cloud.
