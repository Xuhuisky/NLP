% List of function words
functionWords = ["a", "an", "the", ...
    "and", "but", "or", "nor", "for", "so", "yet", ...
    "in", "on", "at", "by", "with", "under", "over", "between", "among", ...
    "he", "she", "it", "we", "you", "they", "me", "him", "her", "us", "them", "this", "that", "these", "those", ...
    "is", "am", "are", "was", "were", "be", "being", "been", "have", "has", "had", "do", "does", "did", "will", "shall", "would", "should", "can", "could", "may", "might", "must", ...
    "can", "could", "may", "might", "will", "would", "shall", "should", "must", ...
    "my", "your", "his", "her", "its", "our", "their", "this", "that", "these", "those", "some", "any", "all", "many", "much", "few", "several", "every", "no", ...
    "which", "who", "why", "how", ...
    "oh", "ah", "wow", "well", "hey", "hi", "hello", "yes", "no", ...
    "about", "above", "across", "after", "against", "along", "among", "around", "before", "behind", "below", "beneath", "beside", "between", "beyond", "during", "inside", "outside", "through", "towards", "underneath", "within", ...
    "of", "to", "as", "from", "into", "onto", ...
    "fig.", "(fig." ...
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ...
    ".", ",", ";", ":", "!", "?", "'", '"', "(", ")", "{", "}", "[", "]", "=", "|", ...
    "et", "al.", "al.,", ...
    "such", "using"];


% Path to the PDF file
pdfFile = '20231201 Solar cell.pdf';
str = extractFileText(pdfFile);
% Convert the PDF to text using pdf2txt
[status, cmdout] = system(['pdftotext ' pdfFile ' -']);
% Split the string into words
words = strsplit(str);


% Count the occurrence of each word
wordCounts = containers.Map('KeyType', 'char', 'ValueType', 'int32');
for i = 1:numel(words)
    word = lower(words{i});
    if isKey(wordCounts, word)
        wordCounts(word) = wordCounts(word) + 1;
    else
        wordCounts(word) = 1;
    end
end

% Convert the map to a table
wordCounts = struct2table(cell2struct([values(wordCounts); keys(wordCounts)], {'Count', 'Word'}));

words = wordCounts.Word;

% Find indices of function words
indicesToRemove = ismember(words, functionWords);

% Remove function words from the table
wordCounts = wordCounts(~indicesToRemove,:);

% Sort the table by count
wordCounts = sortrows(wordCounts, 'Count', 'descend');

% Display the top 40 words
disp(wordCounts(1:40, :));

