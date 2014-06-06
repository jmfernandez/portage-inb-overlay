// Quick & dirty app to add the dnie card driver to opensc configuration

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <opensc/scconf.h>

int main(int argc,char **argv) {
  const char *default_filename = "/etc/opensc.conf";
  char * filename = default_filename;
  if(argc>1)
  	filename = argv[1];
  
  scconf_context *ctx = scconf_new(filename);
  if(ctx == NULL) {
    exit(1);
  }
  
  int err = scconf_parse(ctx);
  if(err != 1) {
    exit(2);
  }

  scconf_block **blocks = scconf_find_blocks(ctx, NULL, "app", "default");

  if (blocks[0] == NULL) {
    exit(3);
  }
  scconf_block *block = blocks[0];
  free(blocks);
  
  const scconf_list *list = scconf_find_list(block, "card_drivers");
  
  if(list == NULL) {
    // If not found create a new one
    scconf_put_str(block, "card_drivers", "dnie");
    scconf_put_str(block, "card_drivers", "internal");
  } else {
    // If found check if dnie is already set
    int before = 0;
    while(list != NULL) {
      if(strcmp(list->data, "dnie") == 0) {
        before = 1;
        break;
      }
      list=list->next;
    }
    // If it's not set add it the first one
    if(!before) {
      scconf_item *item;
      for (item = block->items; item != NULL; item = item->next) {
        scconf_list *list, *copy = NULL;
        const char *strings;

        if ((item->type != SCCONF_ITEM_TYPE_VALUE)
          || (strcmp(item->key, "card_drivers") != 0))
            continue;
        list = item->value.list;
        scconf_list_copy(list, &copy);
        scconf_list_destroy(list);
        list = NULL;
        scconf_list_add(&list, "dnie");
        while(copy != NULL) {
          scconf_list_add(&list, copy->data);
          copy=copy->next;
        }
        item->value.list = list;
        break;
      }
    }
  }
  
  blocks = scconf_find_blocks(ctx, block, "card_driver", "dnie");

  if (blocks[0] == NULL) {
    scconf_list *card = NULL;
    scconf_list_add(&card, "dnie");
    scconf_block *subblock = scconf_block_add(ctx, block, "card_driver", card);
    scconf_put_str(subblock, "module", LIBDIR "/opensc/drivers/card_dnie.so");
  }
  free(blocks);
  
  err = scconf_write(ctx, NULL);
  if(err != 0) {
    exit(4);
  }
  
  exit(0);
}
